import 'dart:convert';

import 'package:bp_display/models/API/APIResponse.model.dart';
import 'package:bp_display/models/Order/Order.model.dart';
import 'package:bp_display/models/Order/OrderStatus.enum.dart';
import 'package:bp_display/services/OrderService/Order.Service.dart';
import 'package:http/http.dart' as http;

class OrderAPIService {
  Future<APIResponse> getOrders() async {
    http.Response response = await http.get(Uri.parse('http://localhost:1337/backpoint/openOrders'));
    List<Order> orders = [];
    List<dynamic> json = jsonDecode(response.body);
    for(Map<String, dynamic> order in json) {
      orders.add(Order.fromJson(order));
    }

    return APIResponse(statusCode: response.statusCode, message: "Successfull", data: orders);    
  }

  Future<APIResponse> updateOrder(Order order) async {
    http.Response response = await http.put(Uri.parse('http://localhost:1337/backpoint/updateOrder?id=${order.ID}'),
    body: {
      'status': OrderStatus.Done.toString().split('.').last
    });
    OrderService.orders.remove(order);
    OrderService.ordersNotifier.value = OrderService.orders;
    OrderService.ordersNotifier.notifyListeners();
    return APIResponse(statusCode: response.statusCode, message: "Successfull", data: null);
  }
}