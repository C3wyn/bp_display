import 'dart:convert';

import 'Extras.model.dart';
import 'Ingredients.model.dart';

class OrderItem {
  int ID;
  String Name;
  double Price;
  List<Ingredient> selectedIngredients;
  List<Extra> selectedExtras;
  String? customerDescription;

  OrderItem({
    required this.ID,
    required this.Name,
    required this.Price,
    required this.selectedIngredients,
    required this.selectedExtras,
    this.customerDescription
  });

  

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      ID: json['product']['id'],
      Name: json['product']['Name'],
      Price: json['product']['Price'],
      selectedIngredients: _convertIngredients(json['selectedIngredients']),
      selectedExtras: _convertExtras(json['selectedExtras']),
      customerDescription: json['customerDescription']
    );
  }

  static List<Ingredient> _convertIngredients(List<dynamic> json) {
    List<Ingredient> ingredients = [];
    for(dynamic element in json) {
      ingredients.add(Ingredient.fromJson(element));
    }
    return ingredients;
  }
  
  static List<Extra> _convertExtras(List<dynamic> json) {
    List<Extra> extras = [];
    for(dynamic element in json) {
      extras.add(Extra.fromJson(element));
    }
    return extras;
  }
}