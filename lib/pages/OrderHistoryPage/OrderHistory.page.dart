import 'package:bp_display/models/API/APIResponse.model.dart';
import 'package:bp_display/models/Order/Order.model.dart';
import 'package:bp_display/pages/DisplayPage/Order.widget.dart';
import 'package:bp_display/pages/OrderHistoryPage/OrderHistory.controller.dart';
import 'package:bp_display/services/APIService/API.Service.dart';
import 'package:bp_display/services/OrderService/Order.Service.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {

  
  late final OrderHistoryPageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = OrderHistoryPageController(setState: setState);
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bestellverlauf'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total Orders: ${_controller.maxOrders}'),
          )
        ],
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: OrderService.historyNotifier, 
            builder: (builder, value, child) {
              return Expanded(
                child: ListView.builder(
                  controller: _controller.listPagingController,
                  itemCount: _controller.noMoreData? value.length: value.length + 1,
                  itemBuilder: (context, index) {
                    if(index == value.length && ! _controller.noMoreData) {
                      return const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              Text('Lade weitere Bestellungen...')
                            ],
                          ),
                        ),
                      );
                    }
                    return OrderWidget(order: value[index]);
                  }
                )
              );
            }
          )
        ],
      )
    );
  }
}