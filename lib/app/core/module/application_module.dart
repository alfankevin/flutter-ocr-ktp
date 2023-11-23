import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/core/permission/permission.dart';
import 'package:penilaian/app/data/repositories/auth/auth_repository.dart';
import 'package:penilaian/app/data/repositories/auth/auth_repository_impl.dart';
import 'package:penilaian/app/pages/connectivity/cubit/connectivity_cubit.dart';

import '../permission/permission_impl.dart';

class ApplicationModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<PermissionInterface>(PermissionImpl.new);
    i.addLazySingleton<AuthRepository>(AuthRepositoryImpl.new);
    i.add(ConnectivityCubit.new);
  }
}
