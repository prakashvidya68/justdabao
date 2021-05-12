import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justdabao/main.dart';
import 'package:justdabao/models/product.dart';
import 'package:justdabao/models/restaurant.dart';
import 'package:justdabao/screens/user/cart_screen.dart';
import 'package:justdabao/widget/change_quantity_button.dart';
import 'package:justdabao/widget/list_cards/product_list_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestoMenu extends StatefulWidget {
  static const routeName = '/restoMenu';

  @override
  _RestoMenuState createState() => _RestoMenuState();
}

class _RestoMenuState extends State<RestoMenu> {
  int selectedQuantity = 0;
  @override
  Widget build(BuildContext context) {
    Restaurant resto = ModalRoute.of(context).settings.arguments;

    List<Product> preOrderProducts = resto.products
        .where((Product product) => product.type == "pre")
        .toList();
    List<Product> instantOrderProducts = resto.products
        .where((Product product) => product.type == "instant")
        .toList();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resto.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 16),
                ),
                Text(
                  resto.description,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  resto.address,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 10),
                DottedLine(
                  dashColor: Colors.grey.shade400,
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Ionicons.star,
                              size: 12,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(resto.rating.toString(),
                                style: Theme.of(context).textTheme.subtitle1
                                // .copyWith(fontSize: 16),
                                ),
                          ],
                        ),
                        Text("50+ ratings",
                            style: Theme.of(context).textTheme.subtitle1
                            // .copyWith(fontSize: 16),
                            ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(resto.status == Status.open ? "OPEN" : "CLOSED",
                            style: Theme.of(context).textTheme.headline2
                            // .copyWith(fontSize: 16),
                            ),
                        Text("for delivery",
                            style: Theme.of(context).textTheme.subtitle1
                            // .copyWith(fontSize: 16),
                            ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("₹ " + resto.estimateCost.toInt().toString(),
                            style: Theme.of(context).textTheme.subtitle1
                            // .copyWith(fontSize: 16),
                            ),
                        Text("Cost for two",
                            style: Theme.of(context).textTheme.subtitle1
                            // .copyWith(fontSize: 16),
                            ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 5),
                DottedLine(
                  dashColor: Colors.grey.shade400,
                ),
                SizedBox(height: 10),
                Expanded(
                  child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            child: TabBar(
                                labelColor: Color(0xFF3E3E3E),
                                indicatorSize: TabBarIndicatorSize.label,
                                // indicatorColor: secondaryColor2,
                                indicatorPadding: EdgeInsets.all(10),
                                unselectedLabelColor:
                                    Color.fromRGBO(0, 0, 0, 0.27),
                                labelStyle: TextStyle(fontSize: 25),
                                tabs: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 12.0, bottom: 12.0),
                                    child: Text("Pre - Order",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 12.0, bottom: 12.0),
                                    child: Text("Instant Pickup",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                  ),
                                ]),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10.0)),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Container(
                                  child: Column(
                                    children: List.generate(
                                        preOrderProducts.length, (index) {
                                      Product product = preOrderProducts[index];
                                      return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedQuantity = 1;
                                            });
                                            addProductToCart(context, product);
                                          },
                                          child: ProductListCart(
                                              product: product));
                                    }),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: List.generate(
                                      instantOrderProducts.length,
                                      (index) {
                                        Product product =
                                            instantOrderProducts[index];
                                        return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedQuantity = 1;
                                              });
                                              addProductToCart(
                                                  context, product);
                                            },
                                            child: ProductListCart(
                                                product: product));
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
            context.read(userCartProvider).orderProducts.isNotEmpty &&
                    context.read(userCartProvider).orderProducts != null
                ? GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed(CartScreen.routeName),
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
                          Text("Go to cart",
                              style: Theme.of(context).textTheme.button),
                        ],
                      ),
                    ),
                  )
                : SizedBox()
          ],
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Future addProductToCart(BuildContext context, Product product) {
    return showDialog(
        context: context,
        builder: (BuildContext dialogContext) => StatefulBuilder(
              builder: (context, setState) => SimpleDialog(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Add to Cart"),
                      ProductQuantity(
                        decrementQuantity: () {
                          setState(() {
                            if (selectedQuantity > 1) selectedQuantity--;
                          });
                        },
                        incrementQuantity: () {
                          setState(() {
                            selectedQuantity++;
                          });
                        },
                        selectedQuantity: selectedQuantity,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        onPressed: () async {
                          await context
                              .read(userCartProvider)
                              .addProductToCart(product, selectedQuantity);

                          Navigator.of(context).pop();
                        },
                        child: Text("Add"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: Text("Cancel"),
                      ),
                    ],
                  )
                ],
              ),
            ));
  }
}
