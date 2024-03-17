import 'package:flutter/cupertino.dart';
import 'package:mobile/services/WebSocketClient.dart';

import '../models/Room.dart';

class RoomState extends ChangeNotifier {
  static RoomState? _instance;
  final WebSocketClient webSocketClient = WebSocketClient();
  Room? _currentRoom;
  Room? get currentRoom => _currentRoom;

  RoomState._internal() {
    webSocketClient.roomUpdate.listen((room) {
      setRoom(room);
      notifyListeners();
    });
  }

  factory RoomState() {
    _instance ??= RoomState._internal();
    return _instance!;
  }

  void setRoom(Room room) {
    _currentRoom = room;
  }
}