import 'dart:convert';

import 'package:bp_display/models/API/APIResponse.model.dart';
import 'package:bp_display/models/Order/Order.model.dart';
import 'package:bp_display/services/APIService/API.Service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:audioplayers/audioplayers.dart';

class OrderService {
  late IO.Socket socket;
  late ValueNotifier<bool> connectedNotifier;

  bool get connected => socket.connected;

  static List<Order> orders = [];
  static ValueNotifier<List<Order>> ordersNotifier = ValueNotifier(orders);

  static List<Order> history = [];
  static ValueNotifier<List<Order>> historyNotifier = ValueNotifier(history);

  connectSocket(BuildContext context) {

    connectedNotifier = ValueNotifier(false);

    socket = IO.io('http://localhost:1337', <String, dynamic>{
      'timeout': 10000
    });
    socket.onConnect(
      (data) => _onSocketConnect(data, context)
    );
    socket.onConnectError((data) => _onSocketConnectError(data, context));
    socket.on('openOrders', (data) => _onOpenOrders(data));
    socket.onDisconnect((_) => _onDisconnect(_));
    socket.on('fromServer', (_) => print(_));
  }

  /// Callback function that is called when a new order is received.
  /// It takes in a [data] parameter which is a JSON string containing the order information.
  /// It decodes the JSON string into a Map and checks if the action is "New Order".
  /// If it is, it creates a new Order object from the result and adds it to the [orders] list.
  /// It then tries to play a sound using the AudioPlayer class and notifies the [ordersNotifier] listeners of the changes.
  /// Finally, it updates the [ordersNotifier] value with the updated [orders] list.
  void _onOpenOrders(data) {
    Map<String, dynamic> json = jsonDecode(data);
    if(json['action']=="New Order"){
      orders.add(Order.fromJson(json['result']));
      try {
        AudioPlayer().play(AssetSource('service_bell.mp3'));
      }catch(_){
        print("AudioPlayer not supported");
      }
    }
    ordersNotifier.value = orders;
    ordersNotifier.notifyListeners();
  }

  _onSocketConnectError(data, BuildContext context) {
    connectedNotifier.value = socket.connected;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verbindung fehlgeschlagen'),
        backgroundColor: Colors.red,
      )
    );
  }
  
  _onSocketConnect(data, BuildContext context) async {
    connectedNotifier.value = socket.connected;
    APIResponse response = await APIService.getOrders();
    if(response.isSuccessfull) {
      orders = response.data;
      ordersNotifier.value = orders;
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error.toString()?? "Fehlgeschlagen"),
          backgroundColor: Colors.greenAccent,
        )
      );
    }
  }
  
  _onDisconnect(param0) {
    connectedNotifier.value = socket.connected;
  }
}