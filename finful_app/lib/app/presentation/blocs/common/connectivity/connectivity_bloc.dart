import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../../../core/bloc/base/base_bloc.dart';
import '../../../../../core/bloc/base/bloc_manager.dart';
import '../../../../constants/key/BlocConstants.dart';
import 'connectivity_event.dart';
import 'connectivity_state.dart';

typedef CheckingInternet = Future<List<InternetAddress>> Function(
    String host, {
    InternetAddressType type,
    });

class ConnectivityBloc extends BaseBloc<ConnectivityEvent, ConnectivityState> {
  late final Connectivity _connectivity;
  late final CheckingInternet _internetCheckingFunction;
  late final String _internetCheckingHost;
  late StreamSubscription _subscription;

  ConnectivityBloc(
      super.key, {
        Connectivity? connectivity,
        CheckingInternet? internetCheckingFunction,
        String? internetCheckingHost,
      })  : _connectivity = connectivity ?? Connectivity(),
        _internetCheckingHost = internetCheckingHost ?? 'google.com',
        _internetCheckingFunction =
            internetCheckingFunction ?? InternetAddress.lookup,
        super(
        initialState: const ConnectivityInitial(),
      ) {
    _subscription = _connectivity.onConnectivityChanged.listen(
          (List<ConnectivityResult> result) async {
        final isConnected = await _checkConnection();

        if (isConnected != state.isConnected) {
          add(ConnectivityChanged(isConnected));
        }
      },
    );
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();

    await super.close();
  }

  factory ConnectivityBloc.instance() {
    return BlocManager().newBloc<ConnectivityBloc>(BlocConstants.connectivity);
  }

  Future<bool> _checkConnection() async {
    var hasConnection = state.isConnected;
    try {
      final result = await _internetCheckingFunction(_internetCheckingHost);
      hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      hasConnection = false;
    }

    return hasConnection;
  }
}
