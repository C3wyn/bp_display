import 'dart:convert';

import 'package:bp_display/environment.dart';
import 'package:bp_display/models/API/APIResponse.model.dart';
import 'package:bp_display/models/Order/Order.model.dart';
import 'package:bp_display/models/Order/OrderStatus.enum.dart';
import 'package:bp_display/services/OrderService/Order.Service.dart';
import 'package:http/http.dart' as http;

class OrderAPIService {
  final Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  Future<APIResponse> getOrders() async {
    http.Response response =
        await http.get(Uri.parse('${ENVIRONMENT.API_URL}/openOrders'));
    List<Order> orders = [];
    List<dynamic> json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> order in json) {
        orders.add(Order.fromJson(order));
      }
    }
    return APIResponse(statusCode: response.statusCode, data: orders);
  }

  Future<APIResponse> updateOrder(Order order) async {
    http.Response response = await http.put(
        Uri.parse('${ENVIRONMENT.API_URL}/updateOrder/${order.ID}'),
        headers: headers,
        body: jsonEncode(
            {'status': OrderStatus.Done.toString().split('.').last}));
    OrderService.orders.remove(order);
    OrderService.ordersNotifier.value = OrderService.orders;
    OrderService.ordersNotifier.notifyListeners();
    return APIResponse(data: null);
  }

  Future<APIResponse> getOrderHistory({int? index}) async {
    http.Response response = await http.get(
        Uri.parse("${ENVIRONMENT.API_URL}/orderHistory?page=${index ?? 1}"));
    List<Order> orders = [];
    List<dynamic> json = jsonDecode(response.body);
    print(json);
    for (Map<String, dynamic> order in json) {
      orders.add(Order.fromJson(order));
    }
    return APIResponse(data: orders);
  }
}
