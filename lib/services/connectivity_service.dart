// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
// class ConnectivityService {
//   final Connectivity _connectivity = Connectivity();
//   StreamController<ConnectivityResult> connectivityController = StreamController<ConnectivityResult>.broadcast();
//
//   ConnectivityService() {
//     _connectivity.onConnectivityChanged.listen(( result) =>
//       connectivityController.add( );
//     );
//   }
//
//   void dispose() {
//     connectivityController.close();
//   }
// }
