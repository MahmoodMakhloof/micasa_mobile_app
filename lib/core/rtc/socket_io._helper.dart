import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketIOHelper {
  static late io.Socket socket;

  static void init() {
    try {
      socket = io
          .io("https://5cd5-154-182-208-237.ngrok-free.app", <String, dynamic>{
        'autoConnect': true,
        'transports': ['websocket'],
      });
      socket.connect();
      socket.onConnect((_) {
        log('Connection Established');
      });
      socket.onDisconnect((_) => log('Connection Disconnection'));
      socket.onConnectError((err) {
        log(err);
        // init();
      });
      socket.onError((err) => log(err));
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
