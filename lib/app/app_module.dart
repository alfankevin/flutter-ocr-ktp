import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/pages/connectivity/connectivity_page.dart';
import 'package:penilaian/app/routes/app_routes.dart';

import 'core/module/application_module.dart';
import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';
import 'pages/splash/splash_page.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        ApplicationModule(),
        HomeModule(),
        AuthModule(),
      ];

  @override
  void routes(r) {
    r.child(AppRoutes.SPLASH, child: (_) => const SplashPage());
    r.child(AppRoutes.NO_INTERNET, child: (context) => const ConnectivityPage());
    r.module('/', module: AuthModule());
    r.module('/', module: HomeModule());
  }
}
