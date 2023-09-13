import 'dart:convert';
import 'dart:js';

import 'package:bp_display/models/API/APIResponse.model.dart';
import 'package:bp_display/models/Order/Order.model.dart';
import 'package:bp_display/services/APIService/API.Service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class OrderService {
  late IO.Socket socket;

  get connected => socket.connected;

  static List<Order> orders = [];
  static ValueNotifier<List<Order>> ordersNotifier = ValueNotifier(orders);

  connectSocket(BuildContext context) {
    socket = IO.io('http://localhost:1337', <String, dynamic>{
      'timeout': 10000
    });
    socket.onConnect(
      (data) => _onSocketConnect(data, context)
    );
    socket.onConnectError((data) => _onSocketConnectError(data, context));
    socket.on('openOrders', (data) => _onOpenOrders(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  static _onOpenOrders(data) {
    Map<String, dynamic> json = jsonDecode(data);
    if(json['action']=="New Order"){
        orders.add(Order.fromJson(json['result']));
    }
    ordersNotifier.value = orders;
    ordersNotifier.notifyListeners();
  }

  static _onSocketConnectError(data, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verbindung fehlgeschlagen'),
        backgroundColor: Colors.red,
      )
    );
  }
  
  static _onSocketConnect(data, BuildContext context) async {
    APIResponse response = await APIService.getOrders();
    if(response.statusCode == 200) {
      orders = response.data;
      ordersNotifier.value = orders;
      ordersNotifier.notifyListeners();
    }
  }
}