import 'dart:convert';

import 'package:bp_display/models/API/APIResponse.model.dart';
import 'package:bp_display/models/Order/Order.model.dart';

import 'Order/Order.APIService.dart';

class APIService {
  static final OrderAPIService _orderService = OrderAPIService();

  static Future<APIResponse> getOrders() async =>
      _handleErrors(_orderService.getOrders());
  static Future<APIResponse> updateOrder(Order order) async =>
      _handleErrors<void>(_orderService.updateOrder(order));
  static Future<APIResponse> getOrderHistory({int? index}) async =>
      _handleErrors(_orderService.getOrderHistory(index: index));
  static Future<APIResponse> _handleErrors<t>(
      Future<APIResponse<t>> next) async {
    //try {
    APIResponse response = await next;
    return response;
    /*}catch(error){
      return APIResponse(
        error: {
          'status': 500,
          'naem': 'Internal Server Error',
          'message': error.toString()
        },
        data: null
      );
    }*/
  }
}
