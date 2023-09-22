import 'package:bp_display/models/API/APIResponse.model.dart';
import 'package:bp_display/models/Order/Order.model.dart';
import 'package:bp_display/services/APIService/API.Service.dart';
import 'package:bp_display/services/OrderService/Order.Service.dart';
import 'package:flutter/material.dart';

class OrderHistoryPageController {

  late Future<APIResponse> getOrdersRequest;
  List<Order> orderList = [];
  final ScrollController listPagingController = ScrollController();
  int loadedIndex = 1;
  bool noMoreData = false;
  final int pageSize = 5;
  int maxOrders = 0;

  late Function setState;

  OrderHistoryPageController({required this.setState}) {
    
    getOrdersRequest = APIService.getOrderHistory();
    getOrdersRequest.then((response) {
      OrderService.historyNotifier.value = response.data;
      
      setState(() {
        maxOrders = response.meta?['pagination']['total'];
      });
    });
    
    listPagingController.addListener(onScrollBottomReached);
  }

  onScrollBottomReached() async {
    if(listPagingController.position.pixels == listPagingController.position.maxScrollExtent && !noMoreData) {
        loadedIndex++;
         
        var neworders = await APIService.getOrderHistory(index: loadedIndex);
        if(OrderService.historyNotifier.value.length >= maxOrders) {
          noMoreData = true;
        }
        OrderService.historyNotifier.value.addAll(neworders.data);
        OrderService.historyNotifier.notifyListeners();
      }
  }
}