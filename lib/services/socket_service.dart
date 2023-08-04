
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus{
  Online,
  Offline,
  Connecting,
}
 
class SocketService with ChangeNotifier {
  ServerStatus  _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
   IO.Socket get socket => this._socket;



  SocketService(){
    _initConfig();
  }
 
  void _initConfig(){  
     _socket = IO.io(
      "http://10.0.2.2:3000",
      OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect() 
        .build()
    );
 
    _socket.onConnect((_) {
      _socket.emit('mensaje', 'conectado desde app Flutter');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
 
    _socket.onDisconnect((_) {
        _socket.emit('disconnect', 'desconectano desde app Flutter');
       _serverStatus = ServerStatus.Offline;
       notifyListeners();
    });
  }
}