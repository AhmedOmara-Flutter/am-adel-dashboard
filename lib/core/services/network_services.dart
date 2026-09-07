import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkService {
  final Connectivity _connectivity = Connectivity();

  Stream<bool> get onStatusChange async* {
    await for (final _ in _connectivity.onConnectivityChanged) {
      yield await InternetConnection().hasInternetAccess;
    }
  }

  Future<bool> hasInternet() async {
    return await InternetConnection().hasInternetAccess;
  }
}