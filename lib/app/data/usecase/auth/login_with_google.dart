import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/core/helpers/result_helper.dart';
import 'package:penilaian/app/core/helpers/usecase_helper.dart';
import 'package:penilaian/app/data/repositories/auth/auth_repository.dart';

class LoginWithGoogleUseCase extends UseCase<User, NoParams> {
  final AuthRepository _auth = Modular.get();
  late final String tag;

  LoginWithGoogleUseCase() {
    tag = runtimeType.toString();
  }

  @override
  Future<Result<User>> call(NoParams params) async {
    if (!await hasInternetConnection) {
      return Result.noInternet();
    }
    return _auth.loginGoogle();
  }
}
