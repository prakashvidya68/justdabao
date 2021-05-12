import 'package:flutter/widgets.dart';
import 'package:justdabao/models/order.dart';
import 'package:justdabao/models/product.dart';

enum Status {
  closed,
  open,
}

class Restaurant {
  final String name;
  final String ownerId;
  final String restoId;
  String description;
  String dp;
  double rating;
  Status status;
  List<Product> products;
  List<Order> orders;
  String address;
  double estimateCost;

  Restaurant({
    @required this.name,
    @required this.ownerId,
    @required this.restoId,
    this.description,
    this.dp,
    this.rating,
    this.status,
    this.products,
    this.orders,
    this.address,
    this.estimateCost,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json["name"],
      ownerId: json["ownerId"],
      restoId: json["restoId"],
      description: json["description"],
      address: json["address"],
      dp: json["dp"],
      estimateCost: json["estimateCost"].toDouble(),
      rating: json["rating"],
      status: json["status"] == "open" ? Status.open : Status.closed,
      products: List<Product>.from(
          ((json["products"]).map((e) => Product.fromJson(e)).toList())),
      orders: json["orders"] == null
          ? null
          : (json["orders"]).map((e) => Product.fromJson(e)).toList(),
    );
  }
}
