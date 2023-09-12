import 'package:bp_display/models/Order/Order.model.dart';
import 'package:bp_display/pages/DisplayPage/Order.widget.dart';
import 'package:bp_display/services/OrderService/Order.Service.dart';
import 'package:flutter/material.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back Point')
      ),
      body: ValueListenableBuilder<List<Order>>(
        valueListenable: OrderService.ordersNotifier,
        builder: (context, orders, child) {
          if(orders.isEmpty){
            return const Center(
              child: Text('No orders yet'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Wrap(
                children: _buildOrderWidgets(orders),
              ),
            )
          );
        }
      )
    );
  }
  
  List<Widget> _buildOrderWidgets(List<Order> orders) {
    List<Widget> widgets = [];
    for(Order order in orders) {
      widgets.add(OrderWidet(order: order));
    }
    return widgets;
  }
}