import 'package:equatable/equatable.dart';

abstract class ConnectivityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConnectivityInitialState extends ConnectivityState {}

class ConnectivityNoInternetState extends ConnectivityState {}

class ConnectivityHasInternetState extends ConnectivityState {
  final List<String> eventsNeedToRetry;

  ConnectivityHasInternetState({required this.eventsNeedToRetry});
}
