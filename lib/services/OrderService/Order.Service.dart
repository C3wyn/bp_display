import 'dart:convert';

import 'package:bp_display/models/API/APIResponse.model.dart';
import 'package:bp_display/models/Order/Order.model.dart';
import 'package:bp_display/services/APIService/API.Service.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class OrderService {
  static IO.Socket socket = IO.io('http://localhost:1337');

  static List<Order> orders = [];
  static ValueNotifier<List<Order>> ordersNotifier = ValueNotifier(orders);

  static connectSocket() {
    socket.onConnect(
      (data) => _onSocketConnect(data)
    );
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
  
  static _onSocketConnect(data) async {
    APIResponse response = await APIService.getOrders();
    if(response.statusCode == 200) {
      orders = response.data;
      ordersNotifier.value = orders;
      ordersNotifier.notifyListeners();
    }
  }
}