import 'package:flutter_modular/flutter_modular.dart';

import 'core/module/application_module.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        ApplicationModule(),
        HomeModule(),
      ];

  @override
  void routes(r) {
    r.module('/', module: HomeModule());
  }
}
