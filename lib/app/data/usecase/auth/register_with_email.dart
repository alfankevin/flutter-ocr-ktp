import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/core/helpers/result_helper.dart';
import 'package:penilaian/app/core/helpers/usecase_helper.dart';
import 'package:penilaian/app/data/repositories/auth/auth_repository.dart';

class RegisterWithEmail extends UseCase<User, RegisterWithEmailParams> {
  final AuthRepository _auth = Modular.get();
  late final String tag;

  RegisterWithEmail() {
    tag = runtimeType.toString();
  }

  @override
  Future<Result<User>> call(RegisterWithEmailParams params) async {
    if (!await hasInternetConnection) {
      return Result.noInternet();
    }
    return _auth.register(params.name, params.email, params.password);
  }
}

class RegisterWithEmailParams extends Equatable {
  final String email;
  final String password;
  final String name;

  const RegisterWithEmailParams({
    required this.email,
    required this.password,
    required this.name,
  });

  RegisterWithEmailParams copyWith({
    String? email,
    String? password,
    String? name,
  }) {
    return RegisterWithEmailParams(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }

  factory RegisterWithEmailParams.fromMap(Map<String, dynamic> map) {
    return RegisterWithEmailParams(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
    );
  }

  @override
  List<Object> get props => [email, password, name];
}
