import 'package:bp_display/models/API/APIResponse.model.dart';
import 'package:bp_display/models/Order/Order.model.dart';

import 'Order/Order.APIService.dart';

class APIService {

  static final OrderAPIService _orderService = OrderAPIService();

  static Future<APIResponse> getOrders() async => _handleErrors(_orderService.getOrders());
  static Future<APIResponse> updateOrder(Order order) async => _handleErrors<void>(_orderService.updateOrder(order));

  static Future<APIResponse> _handleErrors<t>(Future<APIResponse<t>> next) async {
    try {
      APIResponse response = await next;
      if(response == 200) return response;
      return response;
      //throw Exception(response.message);
    }catch(error){
      return APIResponse(
        statusCode: 500,
        message: error.toString(),
        data: null
      );
    }
  }
}