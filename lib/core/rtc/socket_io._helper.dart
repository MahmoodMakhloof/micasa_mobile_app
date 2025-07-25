import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketIOHelper {
  static late io.Socket socket;

  static void init() {
    try {
      socket = io.io("https://e7b0-197-40-255-194.ngrok-free.app", <String, dynamic>{
        'autoConnect': true,
        'transports': ['websocket'],
      });
      socket.connect();
      socket.onConnect((_) {
        log('Connection Established');
      });
      socket.onDisconnect((_) => log('Connection Disconnection'));
      socket.onConnectError((err) {
        log(err.toString());
        // init();
      });
      socket.onError((err) => log(err.toString()));
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> sendMessage(
      String event, Map<String, dynamic> data) async {
    if (event.isEmpty) return;

    socket.emit(event, data);
  }

  static void dispose() {
    socket.disconnect();
    socket.dispose();
  }
}
