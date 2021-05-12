import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justdabao/models/product.dart';

class ProductListCart extends StatelessWidget {
  const ProductListCart({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
            Text(
              product.name,
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),
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
            Text((product.preparationTime ?? 10).toString() + " minutes",
                style: Theme.of(context).textTheme.subtitle1
                // .copyWith(fontSize: 16),
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Ionicons.star,
                  size: 12,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(product.rating.toString(),
                    style: Theme.of(context).textTheme.subtitle1
                    // .copyWith(fontSize: 16),
                    ),
                SizedBox(
                  width: 15,
                ),
                // Spacer(),
                Text("₹ " + product.price.toInt().toString(),
                    style: Theme.of(context).textTheme.subtitle1
                    // .copyWith(fontSize: 16),
                    ),
              ],
            )
          ],
        )
      ],
    );
  }
}
