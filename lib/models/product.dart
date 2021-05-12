class Product {
  Product({
    this.productId,
    this.businessId,
    this.name,
    this.description,
    this.businessName,
    this.image,
    this.price,
    this.isAvailable,
    this.preparationTime,
    this.type,
    this.rating,
  });

  int productId;
  double rating;
  int businessId;
  String name;
  String description;
  String businessName;
  String image;
  double price;
  bool isAvailable;
  String type;
  int preparationTime;

  factory Product.fromJson(json) {
    return Product(
      productId: json["productId"],
      businessId: json["businessId"],
      name: json["name"],
      businessName: json["businessName"],
      description: json["description"],
      rating: json["rating"],
      image: json["image"],
      price: (json["price"] ?? 0).toDouble(),
      isAvailable: json["isAvailable"] == 0 ? false : true,
      preparationTime: json["preparationTime"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "productId": this.productId,
      "businessId": this.businessId,
      "name": this.name,
      "description": this.description,
      "businessName": this.businessName,
      "image": this.image,
      "price": this.price,
      "isAvailable": this.isAvailable,
      "preparationTime": this.preparationTime,
      "type": this.type,
      "rating": this.rating,
    };
  }

  @override
  String toString() {
    return "#" + productId.toString() + " " + name;
  }
}

// var sampleResponseProductList = [
//   Product(
//       productId: 6,
//       businessId: 2,
//       productName: "Triple Rose",
//       description: "3 roses :/",
//       image: 's3://product/image',
//       price: 30.00,
//       currency: "SGD",
//       isAvailable: true,
//       preparationTime: 4),
//   Product(
//       productId: 4,
//       businessId: 2,
//       productName: "Triple Rose",
//       description: "3 roses :/",
//       image: 's3://product/image',
//       price: 35.00,
//       currency: "SGD",
//       isAvailable: true,
//       preparationTime: 3),
//   Product(
//       productId: 3,
//       businessId: 2,
//       productName: "Double rose",
//       description: "Double rose flowers",
//       image: 's3://product/image',
//       price: 20.00,
//       currency: "SGD",
//       isAvailable: true,
//       preparationTime: 1),
//   Product(
//       productId: 2,
//       businessId: 2,
//       productName: "Single Rose",
//       description: "A single rose flower",
//       image: 's3://product/image',
//       price: 10.00,
//       currency: "SGD",
//       isAvailable: true,
//       preparationTime: 1),
// ];
