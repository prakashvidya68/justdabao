import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justdabao/models/restaurant.dart';

class ResorantListCard extends StatelessWidget {
  const ResorantListCard({
    Key key,
    @required this.resto,
  }) : super(key: key);

  final Restaurant resto;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          clipBehavior: Clip.hardEdge,
          height: 100,
          width: 80,
          child: Image.network(
            resto.dp,
            fit: BoxFit.fitHeight,
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              resto.name,
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 16),
            ),
            Text(
              resto.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.grey),
            ),
            Text(resto.address, style: Theme.of(context).textTheme.subtitle1
                // .copyWith(fontSize: 16),
                ),
            Row(
              // mainAxisAlignment:
              //     MainAxisAlignment.spaceAround,
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
                SizedBox(
                  width: 4,
                ),
                // Spacer(),
                Text("₹ " + resto.estimateCost.toInt().toString() + " for two",
                    style: Theme.of(context).textTheme.subtitle1
                    // .copyWith(fontSize: 16),
                    ),
              ],
            )
          ],
        )
      ],
    ));
  }
}
