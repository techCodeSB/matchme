import 'dart:convert';

import 'package:matchme/constant.dart';
import 'package:matchme/controller/support.controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as Io;

class SocketController {
  static late Io.Socket socket;

  static void connect(ctx) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final userId = pref.getString("userId");

    socket = Io.io(
      Constant.socket,
      Io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print("Connected...");
      socket.emit("iamin", userId);
    });

    socket.on("admin-message", (data) {
      print(data.runtimeType);
      var msg = jsonDecode(data);
      Provider.of<SupportController>(ctx, listen: false).manualChatInsert({
        "message_by": "admin",
        "message": msg['msg'],
      });
    });
  }
}
