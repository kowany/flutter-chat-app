import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat/global/environment.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  IO.Socket _socket;
  ServerStatus _serverStatus = ServerStatus.Connecting;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  void connect() async {
    final token = await AuthService.getToken();
    // Dart client
    this._socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });
    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      // print(this._serverStatus);
      notifyListeners();
    });
    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    print('Nos estamos desconectando: ${this._socket}');
    this._socket.disconnect();
  }
}
