import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/helpers/string_helper.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/base/base_app_bar.dart';
import 'package:penilaian/app/core/widgets/base/base_scaffold.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
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
  bool filledAll = true;

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
    final penilaian = await _penilaianRef.once();
    final kriteria = (await _kriteriaRef.once()).snapshot.children;
    Map<String, bool> benefitAll = {};
    for (var e in kriteria) {
      final data = e.value as Map<Object?, Object?>;
      benefitAll.addAll({e.key!: data['is_benefit'] as bool});
    }
    print(benefitAll);
    Map<String, Map<String, num>> matrix = {};
    Map<String, Map<String, num>> minMax = {};
    final pen = penilaian.snapshot.value as Map<Object?, Object?>;
    for (var e in pen.keys) {
      matrix[e.toString()] = {};
      minMax[e.toString()] = {
        'min': 100000,
        'max': 0,
      };
      final data = pen[e] as Map<Object?, Object?>;
      if (kriteria.length != data.length) {
        context.showSnackbar(message: "Data penilaian belum lengkap", error: true, isPop: true);
      }
      for (var key in data.keys) {
        final isi = data[key.toString()] as Map<Object?, Object?>;
        matrix[e.toString()]!.addAll({
          key.toString(): isi['nilai'] as num,
        });
        if (isi['nilai'] as num > minMax[e.toString()]!['max']!) {
          minMax[e.toString()]!['max'] = isi['nilai'] as num;
        }
        if (isi['nilai'] as num < minMax[e.toString()]!['min']!) {
          minMax[e.toString()]!['min'] = isi['nilai'] as num;
        }
      }
    }
    print(minMax);
    for (var e in matrix.keys) {
      final data = matrix[e]!;
      for (var key in data.keys) {
        final nilai = data[key] as num;
        if (benefitAll[key]!) {
          matrix[e]![key] = nilai / minMax[e]!['max']!;
        } else {
          print("Min => ${minMax[e]!['min']}");
          matrix[e]![key] = minMax[e]!['min']! / nilai;
        }
      }
    }
    print(matrix);
    context.hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: "Alternatif",
      ),
      body: FirebaseAnimatedList(
        query: _alternatifRef,
        itemBuilder: (context, snapshot, anim, i) {
          final data = KtpModel.fromMap(snapshot.value as Map<Object?, Object?>);
          filledAll &= data.filled;
          return AlternatifCard(
            number: i + 1,
            data: data,
            onDelete: () async {
              await _alternatifRef.child(snapshot.key!).remove();
              await _storageRef.child('${snapshot.key!}.jpg').delete();
            },
            onEdit: () async {
              await Modular.get<SelectedLocalServices>().setSelectedEdit(snapshot.key!);
              Modular.to.pushNamed(AppRoutes.ktpResultHome, arguments: data);
            },
            onTap: () async {
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
                  context.to.pushNamed(AppRoutes.ktpScanHome);
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
                onPressed: filledAll
                    ? () {
                        penilaian();
                      }
                    : null,
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
