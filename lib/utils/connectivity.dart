import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionStatus {
  //This creates the single instance by calling
  // the `_internal` constructor specified below
  static final ConnectionStatus _singleton =  ConnectionStatus._internal();

  ConnectionStatus._internal();

  //This is what's used to retrieve the instance through the app
  static ConnectionStatus getInstance() => _singleton;
  Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false; // No internet connection
    } else {
      return true; // Internet connection available
    }
  }


}



