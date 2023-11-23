import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/core/helpers/result_helper.dart';
import 'package:penilaian/app/core/helpers/usecase_helper.dart';
import 'package:penilaian/app/data/repositories/auth/auth_repository.dart';

class LoginWithEmail extends UseCase<User, LoginWithEmailParams> {
  final AuthRepository _auth = Modular.get();
  late final String tag;

  LoginWithEmail() {
    tag = runtimeType.toString();
  }

  @override
  Future<Result<User>> call(LoginWithEmailParams params) async {
    if (!await hasInternetConnection) {
      return Result.noInternet();
    }
    return _auth.loginEmail(params.email, params.password);
  }
}

class LoginWithEmailParams extends Equatable {
  final String email;
  final String password;

  const LoginWithEmailParams({
    required this.email,
    required this.password,
  });

  LoginWithEmailParams copyWith({
    String? email,
    String? password,
  }) {
    return LoginWithEmailParams(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginWithEmailParams.fromMap(Map<String, dynamic> map) {
    return LoginWithEmailParams(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  @override
  List<Object> get props => [email, password];
}
