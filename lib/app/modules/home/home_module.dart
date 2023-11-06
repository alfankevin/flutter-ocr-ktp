import 'package:flutter_modular/flutter_modular.dart';
import 'ktp_scan/ktp_scan_page.dart';

import 'cubit/home_cubit.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  void binds(b) {
    b.addLazySingleton((i) => HomeCubit());
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
    r.child('/ktp-scan', child: (context) => const KtpScanPage());
  }
}
