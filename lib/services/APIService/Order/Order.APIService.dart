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
    Map<String, dynamic> json = jsonDecode(response.body);
    if(json['error']==null) {
      for(Map<String, dynamic> order in json['data']) {
        orders.add(Order.fromJson(order));
      }
    }
    

    return APIResponse(
      data: orders,
      error: json['error'],
      meta: json['meta']
    );    
  }

  Future<APIResponse> updateOrder(Order order) async {
    http.Response response = await http.put(Uri.parse('http://localhost:1337/backpoint/updateOrder?id=${order.ID}'),
    body: {
      'status': OrderStatus.Done.toString().split('.').last
    });
    OrderService.orders.remove(order);
    OrderService.ordersNotifier.value = OrderService.orders;
    OrderService.ordersNotifier.notifyListeners();
    return APIResponse(data: null);
  }

  Future<APIResponse> getOrderHistory({int? index}) async {
    http.Response response = await http.get(
      Uri.parse("http://localhost:1337/api/orders?filters[Status][\$eq]=Done&pagination[pageSize]=5&pagination[page]=${index?? 1}&sort=finishedTime:desc")
    );
    List<Order> orders = [];
    Map<String, dynamic> json = jsonDecode(response.body);
    for(Map<String, dynamic> order in json['data']) {
      orders.add(Order.fromJsonWithAtributtes(order));
    }
    return APIResponse(data: orders, error: json['error'], meta: json['meta']);
  }
}