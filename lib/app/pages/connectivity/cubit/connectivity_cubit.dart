import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final List<String> _eventsNeedToRetry = [];

  ConnectivityCubit() : super(ConnectivityInitialState());

  void noInternetConnection({String? event}) {
    if (event != null) {
      if (!_eventsNeedToRetry.contains(event)) {
        _eventsNeedToRetry.add(event);
      }
    }

    emit(ConnectivityNoInternetState());
  }

  Future<void> recheckInternetConnection() async {
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      emit(
        ConnectivityHasInternetState(
          eventsNeedToRetry: List.from(_eventsNeedToRetry),
        ),
      );
      _eventsNeedToRetry.clear();
    }
  }
}
