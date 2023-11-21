import 'package:flutter_modular/flutter_modular.dart';

import 'core/module/application_module.dart';
import 'modules/home/home_module.dart';
import 'modules/auth/auth_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        ApplicationModule(),
        HomeModule(),
        AuthModule(),
      ];

  @override
  void routes(r) {
    r.module('/', module: AuthModule());
    r.module('/home', module: HomeModule());
  }
}
