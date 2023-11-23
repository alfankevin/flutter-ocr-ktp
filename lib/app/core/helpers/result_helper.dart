// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter_modular/flutter_modular.dart';
import 'package:penilaian/app/pages/connectivity/cubit/connectivity_cubit.dart';

abstract class Status {
  static var success = Success();
  static var noInternet = NoInternet();
  static var error = Error();
  static var tokenExpired = TokenExpired();
}

class Success extends Status {}

class NoInternet extends Status {}

class Error extends Status {}

class TokenExpired extends Status {}

class Result<R> {
  late R data;
  late Status status;
  final ConnectivityCubit _connectivityCubit = Modular.get<ConnectivityCubit>();

  int code;
  String message;

  dynamic when({
    required Function(R r) success,
    required Function(String l) error,
    Function()? orElse,
  }) {
    switch (status.runtimeType) {
      case Success:
        return success.call(data);
      case NoInternet:
        _connectivityCubit.noInternetConnection(event: message);
        return error.call(message);
      case Error:
        return error.call(message);
      default:
        return orElse?.call() ?? error.call(message);
    }
  }

  Result.success(
    this.data, {
    this.message = "",
    this.code = 200,
  }) : status = Status.success;

  Result.noInternet({
    this.message = "No Internet Connection",
    this.code = -1,
  }) : status = Status.noInternet;

  Result.error({
    Status? status,
    this.message = "",
    this.code = -1,
  }) : status = status ?? Status.error;

  Result.tokenExpired({
    this.message = "",
    this.code = 401,
  }) : status = Status.tokenExpired;
}
