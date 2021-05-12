import 'package:justdabao/models/product.dart';

class Order {
  Order({
    this.orderId,
    this.userId,
    this.restoId,
    this.name,
    this.orderDate,
    this.paymentAmount,
    this.orderStatus,
    this.orderProducts,
    this.remark,
    this.address,
  });

  String orderId;
  String userId;
  String restoId;
  String name;
  DateTime orderDate;
  double paymentAmount;
  List<Product> orderProducts;
  String remark;
  String orderStatus;
  String address;
  String addressType;
  String country;

  factory Order.fromJson(json) {
    return Order(
      orderId: json["orderId"],
      orderDate: DateTime.parse((json["orderDate"])),
      restoId: json["restoId"],
      name: json["name"],
      paymentAmount: json["paymentAmount"].toDouble(),
      remark: json["remark"] ?? "",
      address: json["address"] ?? "",
      orderStatus: json["orderStatus"],
      orderProducts:
          (json["products"] as List).map((i) => Product.fromJson(i)).toList(),
    );
  }

  updateOrder(Map json) {
    Order update = Order.fromJson(json);
    this.orderId = update.orderId;
    this.userId = update.userId;
    this.name = update.name;
    this.orderDate = update.orderDate;
    this.paymentAmount = update.paymentAmount;
    this.orderProducts = update.orderProducts;
    this.remark = update.remark;
    this.orderStatus = update.orderStatus;
    this.address = update.address;
  }
}

// class OrderProduct {
//   OrderProduct({
//     this.productId,
//     this.name,
//     this.description,
//     this.image,
//     this.quantity,
//     this.spRequestDescription,
//     this.price,
//   });

//   int productId;
//   String name;
//   String description;
//   String image;
//   int quantity;
//   String spRequestDescription;
//   double price;

//   factory OrderProduct.fromJson(json) {
//     return OrderProduct(
//       price: double.parse(json['price'].toString()),
//       productId: json["productId"],
//       name: json["name"],
//       description: json["description"],
//       image: json["productImage"],
//       quantity: json["quantity"],
//       spRequestDescription: json["spRequestDescription"],
//     );
//   }
// }
