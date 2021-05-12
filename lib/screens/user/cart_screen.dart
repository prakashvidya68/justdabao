import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justdabao/main.dart';
import 'package:justdabao/models/cart.dart';
import 'package:justdabao/models/product.dart';
import 'package:justdabao/screens/user/pay_confirm.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cartPage";
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(child: Consumer(
          builder: (context, watchCart, _) {
            Cart cart = watchCart(userCartProvider);
            if (cart.orderProducts.isEmpty) {
              return Center(
                child: Text("Nothing here.."),
              );
            }
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        children:
                            List.generate(cart.orderProducts.length, (index) {
                          Product product = Product.fromJson(
                              cart.orderProducts[index]["product"]);
                          return Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  clipBehavior: Clip.hardEdge,
                                  height: 100,
                                  width: 80,
                                  child: Image.network(
                                    product.image,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          product.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              .copyWith(fontSize: 16),
                                        ),
                                        Text(
                                          " X ${cart.orderProducts[index]["quantity"]}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .copyWith(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      width: 250,
                                      child: Text(
                                        product.description,
                                        overflow: TextOverflow.fade,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    Text(
                                        (product.preparationTime ?? 10)
                                                .toString() +
                                            " minutes",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                        // .copyWith(fontSize: 16),
                                        ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Ionicons.star,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(product.rating.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                            // .copyWith(fontSize: 16),
                                            ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        // Spacer(),
                                        Text(
                                            "₹ " +
                                                product.price
                                                    .toInt()
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                            // .copyWith(fontSize: 16),
                                            ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Cost"),
                                    Text((cart.orderProducts[index]
                                                ["quantity"] *
                                            product.price)
                                        .toString()),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TOTAL",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(fontSize: 16),
                            ),
                            Text(
                              "₹ " + cart.totalCost.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    cart.addProductToCart(null, 0);
                    return Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PaySuccessful()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.bag_outline,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Check out",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ],
                    ),
                  ),
                )
              ],
              alignment: Alignment.bottomCenter,
            );
          },
        )),
      ),
    );
  }
}
