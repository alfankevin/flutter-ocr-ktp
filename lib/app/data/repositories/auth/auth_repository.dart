import 'package:firebase_auth/firebase_auth.dart';
import 'package:penilaian/app/core/typedefs/typedefs.dart';

abstract class AuthRepository {
  ResultResponse<User> loginEmail(String email, String password);
  ResultResponse<User> loginGoogle();

  ResultResponse<User> register(String name, String email, String password);
  Future<void> logout();
  ResultResponse<String> forgotPassword(String email);
  ResultResponse<String> changePassword(String email, String password);
}
