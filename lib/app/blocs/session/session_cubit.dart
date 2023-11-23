import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/data/repositories/auth/auth_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(SessionInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final repo = Modular.get<AuthRepository>();

  Future<void> checkSession() async {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        emit(const SessionNotReadyState());
      } else {
        emit(SessionReadyState(session: user));
      }
    });
  }

  Future<void> deleteSession() async {
    await _auth.signOut();

    emit(const SessionNotReadyState());
  }

  void unAuthorizedToken() {
    emit(SessionUnAuthorizedTokenState());
  }
}
