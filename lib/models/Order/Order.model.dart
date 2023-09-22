import 'dart:convert';

import 'DeliveryType.enum.dart';
import 'OrderItem.model.dart';
import 'OrderStatus.enum.dart';

class Order {
  int ID;
  List<OrderItem> items;
  DeliveryType deliveryType;
  OrderStatus status;
  DateTime pickUpDate;
  DateTime createdAt;
  String? description;

  Order({
    required this.ID,
    required this.items,
    required this.deliveryType,
    required this.status,
    required this.pickUpDate,
    required this.createdAt,
    this.description
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      ID: json['id'],
      items: _convertItems(json['items']),
      deliveryType: _convertDeliveryType(json['deliveryType']),
      status: _convertStatus(json['status']),
      pickUpDate: DateTime.parse(json['pickUpDate']),
      createdAt: DateTime.parse(json['createdAt']),
      description: json['description']
    );
  }
  factory Order.fromJsonWithAtributtes(Map<String, dynamic> json) {
    return Order(
      ID: json['id'],
      items: _convertItems(json['attributes']['items']),
      deliveryType: _convertDeliveryType(json['attributes']['deliveryType']),
      status: _convertStatus(json['attributes']['status']),
      pickUpDate: DateTime.parse(json['attributes']['pickUpDate']),
      createdAt: DateTime.parse(json['attributes']['createdAt']),
      description: json['attributes']['description']
    );
  }
  
  static List<OrderItem> _convertItems(json) {
    List<OrderItem> items = [];
    List<dynamic> jsonItems = json;
    for(Map<String, dynamic> item in jsonItems) {
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