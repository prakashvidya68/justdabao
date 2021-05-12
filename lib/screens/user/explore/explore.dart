import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justdabao/main.dart';
import 'package:justdabao/models/restaurant.dart';
import 'package:justdabao/models/user.dart';
import 'package:justdabao/screens/user/explore/restuarant_menu.dart';
import 'package:justdabao/widget/list_cards/resto_list_card.dart';

class ExploreDestinationPage extends StatefulWidget {
  const ExploreDestinationPage({
    Key key,
  }) : super(key: key);

  @override
  _ExploreDestinationPageState createState() => _ExploreDestinationPageState();
}

class _ExploreDestinationPageState extends State<ExploreDestinationPage> {
  @override
  void initState() {
    super.initState();
    getRestos();
  }

  Future<void> getRestos() async {
    restos = await context.read(firestore).getAllResto(context);
    setState(() {});
  }

  List<Restaurant> restos;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        UserModel user = watch(userProvider);
        print(user.toMap().toString());
        return SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 8),
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Recommended Restaurants near you",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 19),
                ),
                SizedBox(height: 15),
                Consumer(builder: (context, watchResto, _) {
                  restos = watchResto(allResto);
                  if (restos.isNotEmpty) {
                    // When restaurants load up
                    return Expanded(
                      // height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                          itemCount: restos.length,
                          itemBuilder: (context, index) {
                            Restaurant resto = restos[index];
                            return GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                  RestoMenu.routeName,
                                  arguments: resto),
                              child: ResorantListCard(resto: resto),
                            );
                          }),
                    );
                  } else {
                    // print(restos);
                    return SizedBox();
                  }
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
