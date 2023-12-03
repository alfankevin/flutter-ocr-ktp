import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/modules/home/alternatif/alternatif_page.dart';
import 'package:penilaian/app/modules/home/detail_ktp/detail_ktp_page.dart';
import 'package:penilaian/app/modules/home/kriteria/kriteria_page.dart';
import 'package:penilaian/app/modules/home/penilaian/penilaian_page.dart';
import 'package:penilaian/app/routes/app_routes.dart';

import 'cubit/home_cubit.dart';
import 'home_page.dart';
import 'ktp_scan/cubit/ktp_scan_cubit.dart';
import 'ktp_scan/ktp_scan_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.add(HomeCubit.new);
    i.add(KtpScanCubit.new);
  }

  @override
  void routes(r) {
    r.child(AppRoutes.home, child: (context) => const HomePage());
    r.child(AppRoutes.ktpScanHome, child: (context) => const KtpScanPage());
    r.child(AppRoutes.ktpResultHome, child: (context) => DetailKtpPage(nikResult: r.args.data));
    r.child(AppRoutes.kriteriaHome, child: (ctx) => const KriteriaPage());
    r.child(AppRoutes.alternatifHome, child: (ctx) => const AlternatifPage());
    r.child(AppRoutes.penilaianHome, child: (ctx) => const PenilaianPage());
  }
}
