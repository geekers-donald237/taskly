import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:taskly/presentation/blocs/connectivity_bloc/connectivity_bloc.dart';


class ConnectivityService {
  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        ConnectivityBloc().add(OnConnectivityEvent());
      } else {
        ConnectivityBloc().add(OnNotConnectivityEvent());
      }
    });
  }
}
