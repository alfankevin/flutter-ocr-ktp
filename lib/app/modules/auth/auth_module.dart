import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/modules/auth/cubit/auth_cubit.dart';
import 'package:penilaian/app/modules/auth/login/login_page.dart';
import 'package:penilaian/app/modules/auth/register/register_page.dart';
import 'package:penilaian/app/routes/app_routes.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.add(AuthCubit.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(AppRoutes.LOGIN, child: (ctx) => const LoginPage());
    r.child(AppRoutes.REGISTER, child: (ctx) => const RegisterPage());
  }
}
