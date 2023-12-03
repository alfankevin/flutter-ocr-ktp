import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:penilaian/app/core/theme/theme.dart';
import 'package:penilaian/app/core/widgets/base/base_app_bar.dart';
import 'package:penilaian/app/core/widgets/base/base_scaffold.dart';
import 'package:penilaian/app/data/extensions/extensions.dart';
import 'package:penilaian/app/routes/app_routes.dart';

import 'cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeCubit>();
  String file = '';

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const BaseAppBar(
        title: "Beranda",
        isBack: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            HomeCard(
              subTitle:
                  'Mahasiswa yang tidak mampu secara ekonomi namun memiliki potensi akademik yang baik',
              title: 'Bidikmisi',
              onTap: () {
                context.to.pushNamed(AppRoutes.kriteriaHome);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah data',
        onPressed: () async {
          // final rest = await Modular.to.pushNamed(AppRoutes.ktpScanHome);
          // if (rest != null && rest is String) {
          //   setState(() {
          //     file = rest;
          //   });
          // }
        },
        // child: const Icon(Icons.qr_code_scanner_rounded),
        child: const Icon(
          Icons.add_circle_outline_outlined,
          size: 30,
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.srcImg,
    this.onTap,
  });

  final String title;
  final String subTitle;
  final String? srcImg;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: context.width,
      padding: 16.all,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(srcImg ?? 'assets/img/desa.jpg'),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
        borderRadius: 10.rounded,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.text20PxBold.copyWith(color: Colors.white),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                subTitle,
                style: AppStyles.text12Px.copyWith(
                  color: Colors.white,
                ),
              ).expand(flex: 2),
              8.horizontalSpaceRadius,
              OutlinedButton(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 3),
                  disabledForegroundColor: Colors.grey,
                ),
                child: const Text('Lihat'),
              ).expand()
            ],
          ),
        ],
      ),
    );
  }
}
