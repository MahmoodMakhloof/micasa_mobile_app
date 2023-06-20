import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketIOHelper {
  static late io.Socket socket;

  static void init() {
    socket =
        io.io("https://71ff-154-182-140-48.ngrok-free.app", <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      log('Connection Established');
    });
    socket.onDisconnect((_) => log('Connection Disconnection'));
    socket.onConnectError((err) => log(
      
      err));
    socket.onError((err) => log(err));
  }

  static void sendMessage(String event, Map<String, dynamic> data) {
    if (event.isEmpty) return;

    socket.emit(event, data);
  }

  static void dispose() {
    socket.disconnect();
    socket.dispose();
  }
}
