import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/helpers/string_helper.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/base/base_app_bar.dart';
import 'package:penilaian/app/core/widgets/base/base_scaffold.dart';
import 'package:penilaian/app/core/widgets/text/no_found_widget.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/data/models/kriteria_model.dart';
import 'package:penilaian/app/data/models/ktp_model.dart';
import 'package:penilaian/app/data/services/local_services/selected_local_services.dart';
import 'package:penilaian/app/routes/app_routes.dart';

import 'widgets/alternatif_card.dart';

class AlternatifPage extends StatefulWidget {
  const AlternatifPage({super.key});

  @override
  State<AlternatifPage> createState() => _AlternatifPageState();
}

class _AlternatifPageState extends State<AlternatifPage> {
  late final DatabaseReference _alternatifRef;
  late final DatabaseReference _penilaianRef;
  late final DatabaseReference _kriteriaRef;
  late final Reference _storageRef;
  late final String _refKey;

  @override
  void initState() {
    super.initState();
    _refKey = Modular.get<SelectedLocalServices>().selected;
    _alternatifRef = FirebaseDatabase.instance.ref('$_refKey/alternatif');
    _penilaianRef = FirebaseDatabase.instance.ref('$_refKey/penilaian');
    _kriteriaRef = FirebaseDatabase.instance.ref('$_refKey/kriteria');
    _storageRef = FirebaseStorage.instance.ref(StringHelper.imageStorage);
  }

  Future<void> penilaian() async {
    context.showLoadingIndicator();
    final penilaian = await _penilaianRef.orderByChild('created_at').once();
    final kriteria = (await _kriteriaRef.once()).snapshot.children;
    if (kriteria.isEmpty) {
      context.showSnackbar(message: "Data kriteria belum ada!", error: true, isPop: true);
      return;
    }
    if (penilaian.snapshot.children.isEmpty) {
      context.showSnackbar(
          message: "Data alternatif per kriteria belum diisi!", error: true, isPop: true);
      return;
    }
    Map<String, KriteriaModel> kriteriaAll = {};
    num totalW = 0;
    Map<String, Map<String, num>> minMax = {};
    for (var e in kriteria) {
      final data = e.value as Map<Object?, Object?>;
      final model = KriteriaModel.fromMap(data);
      kriteriaAll.addAll({e.key!: model});
      totalW += model.w;
      minMax[e.key.toString()] = {
        'min': 100000,
        'max': 0,
      };
    }
    print(minMax);
    Map<String, Map<String, num>> matrix = {};
    final pen = penilaian.snapshot.value as Map<Object?, Object?>;
    for (var e in pen.keys) {
      matrix[e.toString()] = {};
      final data = pen[e] as Map<Object?, Object?>;
      if (kriteria.length != data.length) {
        context.showSnackbar(message: "Data penilaian belum lengkap", error: true, isPop: true);
        return;
      }
      List<num> kr = [];
      for (var key in data.keys) {
        final isi = data[key.toString()] as Map<Object?, Object?>;
        matrix[e.toString()]!.addAll({isi['kriteria_id'].toString(): (isi['nilai'] as num).round3});
        kr.add(isi['nilai'] as num);
        if (isi['nilai'] as num > minMax[key.toString()]!['max']!) {
          minMax[key.toString()]!['max'] = isi['nilai'] as num;
        }
        if (isi['nilai'] as num < minMax[key.toString()]!['min']!) {
          minMax[key.toString()]!['min'] = isi['nilai'] as num;
        }
      }
      print(kr);
    }
    final Map<String, Map<String, dynamic>> parameter = {};
    // Normalisasi
    for (var e in matrix.keys) {
      final data = matrix[e]!;
      for (var key in data.keys) {
        final nilai = data[key] as num;
        if (kriteriaAll[key]!.isBenefit) {
          matrix[e]![key] = (nilai / minMax[key]!['max']!).round3;
        } else {
          // print("Min => ${minMax[e]!['min']}");
          matrix[e]![key] = (minMax[key]!['min']! / nilai).round3;
        }
        // perhitungan parameter
        if (parameter[key] == null) {
          num w = (kriteriaAll[key]!.w / totalW) * 100;
          parameter[key] = {
            'g-': matrix[e]![key],
            'g+': matrix[e]![key],
            'i': w,
            'beda': w,
          };
        }
        if (matrix[e]![key]! < parameter[key]!['g-']!) {
          parameter[key]!['g-'] = matrix[e]![key];
        }
        if (matrix[e]![key]! > parameter[key]!['g+']!) {
          parameter[key]!['g+'] = matrix[e]![key];
        }
      }
    }
    // print(matrix);
    for (var e in parameter.keys) {
      num beda = (parameter[e]!['g+']! - parameter[e]!['g-']!) / parameter[e]!['i']!;
      parameter[e]!['beda'] = beda.round3;
      print("$e => ${parameter[e]}");
    }
    // print(parameter);
    // perengkingan
    final Map<String, num> ranking = {};
    for (var e in matrix.keys) {
      final data = matrix[e]!;
      ranking[e] = 0;
      for (var key in data.keys) {
        matrix[e]![key] = (matrix[e]![key]! * parameter[key]!['beda']!).round3;
        ranking[e] = ranking[e]! + matrix[e]![key]!;
      }
      await _alternatifRef.child(e).update({'nilai': ranking[e]!.round3, 'filled': true});
    }
    // print(ranking);
    context.hideLoading();
    context.to.pushNamed(AppRoutes.winnerHome);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: "Alternatif",
      ),
      body: RealtimeDBPagination(
        query: _alternatifRef.orderByChild('created_at'),
        orderBy: null,
        isLive: true,
        onEmpty: const NoFoundWidget(),
        separatorBuilder: (p0, p1) => 12.verticalSpacingRadius,
        itemBuilder: (context, snapshot, i) {
          final data = KtpModel.fromMap(snapshot.value as Map<Object?, Object?>);
          return AlternatifCard(
            number: i + 1,
            data: data,
            onDelete: () async {
              await _alternatifRef.child(snapshot.key!).remove();
              await _penilaianRef.child(snapshot.key!).remove();
              await _storageRef.child('${snapshot.key!}.jpg').delete();
            },
            onEdit: () async {
              await Modular.get<SelectedLocalServices>().setSelectedEdit(snapshot.key!);
              Modular.to.pushNamed(AppRoutes.ktpResultHome, arguments: data);
            },
            onTap: () async {
              print(snapshot.key!);
              await Modular.to.pushNamed(AppRoutes.penilaianHome, arguments: snapshot.key!);
              final pen = await _penilaianRef.child(snapshot.key!).once();
              final kriteria = await _kriteriaRef.once();
              bool filled = pen.snapshot.children.length == kriteria.snapshot.children.length;
              await _alternatifRef.child(snapshot.key!).update({'filled': filled});
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: 16.all.copyWith(top: 0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorTheme.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      bottomLeft: Radius.circular(16.r),
                    ),
                  ),
                  textStyle: AppStyles.text16PxMedium,
                  minimumSize: Size(200.r, 48.r),
                ),
                onPressed: () {
                  context.to.pushNamed(AppRoutes.ktpScanHome).then((value) => setState(() {}));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.qr_code_scanner_rounded),
                    6.horizontalSpaceRadius,
                    const Text('Tambah'),
                  ],
                ),
              ),
            ),
            12.horizontalSpaceRadius,
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorTheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.r),
                      bottomRight: Radius.circular(16.r),
                    ),
                  ),
                  textStyle: AppStyles.text16PxMedium,
                  minimumSize: Size(200.r, 48.r),
                ),
                onPressed: () {
                  penilaian();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Hitung'),
                    6.horizontalSpaceRadius,
                    const Icon(Icons.calculate),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
