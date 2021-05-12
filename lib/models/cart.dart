import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:justdabao/main.dart';
import 'package:justdabao/models/product.dart';

class Cart extends ChangeNotifier {
  ProviderReference ref;

  double totalCost;
  List orderProducts;
  String userId;

  Cart({this.totalCost, this.orderProducts, this.userId, this.ref});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      totalCost: json["totalCost"],
      orderProducts: json["orderProducts"] ?? [],
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "totalCost": this.totalCost,
      "orderProducts": this.orderProducts,
      "userId": this.userId,
    };
  }

  updateLocalCart(Cart cartModel) {
    this.totalCost = cartModel.totalCost;
    this.orderProducts = cartModel.orderProducts;
    this.userId = cartModel.userId;

    notifyListeners();
  }

  Future addProductToCart(Product product, int quantity) async {
    var db = ref.read(firestore);
    if (this.orderProducts == null) {
      this.orderProducts = <Map<String, dynamic>>[];
    }
    this.userId = (this.userId ?? ref.read(userProvider).uid);
    this.totalCost = (this.totalCost ?? 0) + (product.price * quantity);
    this.orderProducts.add({"product": product.toJson(), "quantity": quantity});
    db.addProductToCart(this.userId, this);
    notifyListeners();
  }
}
