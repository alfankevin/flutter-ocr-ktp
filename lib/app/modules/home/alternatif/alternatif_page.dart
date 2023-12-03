import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/base/base_app_bar.dart';
import 'package:penilaian/app/core/widgets/base/base_scaffold.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/routes/app_routes.dart';

class AlternatifPage extends StatefulWidget {
  const AlternatifPage({super.key});

  @override
  State<AlternatifPage> createState() => _AlternatifPageState();
}

class _AlternatifPageState extends State<AlternatifPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: "Alternatif",
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                height: 63,
                width: 44,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "1",
                  style: AppStyles.text14Px.copyWith(color: ColorTheme.white),
                ),
              ),
              8.horizontalSpaceRadius,
            ],
          ),
        ],
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
                onPressed: () {},
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
