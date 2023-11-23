part of 'session_cubit.dart';

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

final class SessionInitial extends SessionState {}

class SessionNotReadyState extends SessionState {
  const SessionNotReadyState() : super();
}

class SessionReadyState extends SessionState {
  final User session;

  const SessionReadyState({
    required this.session,
  }) : super();

  @override
  List<Object> get props => [];
}

class SessionUnAuthorizedTokenState extends SessionState {}
