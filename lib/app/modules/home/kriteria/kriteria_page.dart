import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/base/base_app_bar.dart';
import 'package:penilaian/app/core/widgets/base/base_scaffold.dart';
import 'package:penilaian/app/core/widgets/text/no_found_widget.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/data/models/kriteria_model.dart';
import 'package:penilaian/app/data/services/local_services/selected_local_services.dart';
import 'package:penilaian/app/routes/app_routes.dart';

import '../../../core/widgets/text/warning_text.dart';
import 'widgets/kriteria_form_card.dart';

class KriteriaPage extends StatefulWidget {
  const KriteriaPage({
    super.key,
  });

  @override
  State<KriteriaPage> createState() => _KriteriaPageState();
}

class _KriteriaPageState extends State<KriteriaPage> {
  final List<String> listKriteria = [16.generateRandomString];

  late DatabaseReference _kriteriaRef;
  late String _refKey;

  @override
  void initState() {
    super.initState();
    _refKey = Modular.get<SelectedLocalServices>().selected;
    _kriteriaRef = FirebaseDatabase.instance.ref('$_refKey/kriteria');
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: "Kriteria",
      ),
      body: Column(
        children: [
          const WarningText(
            text:
                "Untuk menentukan jenis kriteria, dapat diklik bagian kotak nomor. Jika berwarna biru maka kriteria benefit dan berwarna merah untuk cost.",
          ),
          12.verticalSpacingRadius,
          RealtimeDBPagination(
            query: _kriteriaRef,
            orderBy: null,
            onEmpty: const NoFoundWidget(),
            itemBuilder: (context, snapshot, i) {
              final data = KriteriaModel.fromMap(snapshot.value as Map<Object?, Object?>);
              return KriteriaFormCard(
                number: 1,
                name: data.name,
                w: "${data.w}",
                isBenefit: data.isBenefit,
                onChanged: (name, w) {
                  _kriteriaRef.child(snapshot.key!).update(data
                      .copyWith(
                        name: name,
                        w: double.tryParse(w),
                      )
                      .toMap());
                },
                onDelete: () {
                  _kriteriaRef.child(snapshot.key!).remove();
                },
                onTap: () {
                  _kriteriaRef
                      .child(snapshot.key!)
                      .update(data.copyWith(isBenefit: !data.isBenefit).toMap());
                },
              ).py(8);
            },
          ).expand(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: 16.all.copyWith(top: 0),
        child: Row(
          children: [
            12.horizontalSpaceRadius,
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
                  final v = KriteriaModel.init();
                  _kriteriaRef.child(16.generateRandomString).set(v.toMap());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_box_outlined),
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
                  context.to.pushNamed(AppRoutes.alternatifHome);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Alternatif'),
                    6.horizontalSpaceRadius,
                    const Icon(Icons.format_align_center_rounded),
                  ],
                ),
              ),
            ),
            12.horizontalSpaceRadius,
          ],
        ),
      ),
    );
  }
}
