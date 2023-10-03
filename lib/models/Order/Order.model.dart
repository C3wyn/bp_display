import 'dart:convert';

import 'DeliveryType.enum.dart';
import 'OrderItem.model.dart';
import 'OrderStatus.enum.dart';

class Order {
  String ID;
  int orderNumber;
  List<OrderItem> items;
  DeliveryType deliveryType;
  OrderStatus status;
  DateTime pickUpDate;
  DateTime createdAt;
  String? description;

  Order(
      {required this.orderNumber,
      required this.ID,
      required this.items,
      required this.deliveryType,
      required this.status,
      required this.pickUpDate,
      required this.createdAt,
      this.description});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        orderNumber: json['orderNumber'],
        ID: json['_id'],
        items: _convertItems(json['items']),
        deliveryType: _convertDeliveryType(json['deliveryType']),
        status: _convertStatus(json['status']),
        pickUpDate: DateTime.parse(json['pickUpDate']),
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        description: json['description']);
  }

  static List<OrderItem> _convertItems(json) {
    List<OrderItem> items = [];
    List<dynamic> jsonItems = json;
    for (Map<String, dynamic> item in jsonItems) {
      items.add(OrderItem.fromJson(item));
    }
    return items;
  }

  static DeliveryType _convertDeliveryType(json) {
    switch (json) {
      case 'Take Away':
        return DeliveryType.TakeAway;
      default:
        return DeliveryType.EatHere;
    }
  }

  static OrderStatus _convertStatus(json) {
    switch (json) {
      case 'Accepted':
        return OrderStatus.Accepted;
      case 'Aborted':
        return OrderStatus.Aborted;
      case 'Done':
        return OrderStatus.Done;
      default:
        return OrderStatus.Created;
    }
  }
}
