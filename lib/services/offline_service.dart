import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';


enum ServerStatus {Online, Offline, Connecting}

class OfflineService with ChangeNotifier {

  StreamSubscription? subscription;
  SimpleConnectionChecker _simpleConnectionChecker = SimpleConnectionChecker()
    ..setLookUpAddress('www.google.com');
  //variables privadas
  ServerStatus _serverStatus = ServerStatus.Connecting;

  //metodos para acceder a variables privadas
  ServerStatus get serverStatus => this._serverStatus;

  void conectar() {
    subscription = _simpleConnectionChecker.onConnectionChange.listen((connected) {
      _serverStatus = connected? ServerStatus.Online: ServerStatus.Offline;
      notifyListeners();
    });
  }

  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

}
