import 'package:bp_display/models/Order/Order.model.dart';
import 'package:bp_display/pages/DisplayPage/Order.widget.dart';
import 'package:bp_display/services/APIService/API.Service.dart';
import 'package:bp_display/services/OrderService/Order.Service.dart';
import 'package:flutter/material.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {

  late OrderService _orderService;

  @override
  void initState() {
    super.initState();
    _orderService = OrderService();
    _orderService.connectSocket(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: _orderService.connectedNotifier,
                builder: (context, connected, child) {
                  if(connected) {
                    return const Icon(Icons.wifi);
                  }
                  return const Icon(Icons.wifi_off);
                }
              ),
            ],
          ),
        ),
        title: Text('Back Point', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          ValueListenableBuilder(
            valueListenable: _orderService.connectedNotifier, 
            builder: (context, value, child) {
              return IconButton(
                onPressed: value? _onRefreshClicked: null,
                icon: const Icon(Icons.refresh)
              );
            }
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => _onHistoryClicked(context),
          )
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: ValueListenableBuilder<List<Order>>(
            valueListenable: OrderService.ordersNotifier,
            builder: (context, orders, child) {
              if(!_orderService.connected){
                return const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Connecting to server...'),
                    ],
                  ),
                );
              } else if(orders.isEmpty && _orderService.connected){
                return const Center(
                  child: Text('No orders yet'),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    children: _buildOrderWidgets(orders),
                  ),
                )
              );
            }
          ),
        ),
      )
    );
  }
  
  List<Widget> _buildOrderWidgets(List<Order> orders) {
    List<Widget> widgets = [];
    for(Order order in orders) {
      widgets.add(OrderWidget(order: order));
    }
    return widgets;
  }

  void _onRefreshClicked() async {
    OrderService.orders = [];
    OrderService.ordersNotifier.value = (await APIService.getOrders()).data;
  }

  void _onHistoryClicked(BuildContext context) async {
    await Navigator.of(context).pushNamed('/orderHistory');
  }
}