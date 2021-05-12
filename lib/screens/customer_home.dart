import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:justdabao/main.dart';
import 'package:justdabao/models/user.dart';
import 'package:justdabao/screens/user/account/account.dart';
import 'package:justdabao/screens/user/cart_screen.dart';
import 'package:justdabao/screens/user/explore/explore.dart';

class Destination {
  const Destination(this.index, this.icon, this.screen);

  final int index;
  final IconData icon;
  final Widget screen;
}

class CustomerHome extends StatefulWidget {
  const CustomerHome({
    Key key,
  }) : super(key: key);

  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  int selectedTab = 0;
  var allDestinations = <Destination>[
    Destination(0, Ionicons.home_outline, ExploreDestinationPage()),
    Destination(
      1,
      Ionicons.search_circle_outline,
      Container(child: Text("secrch")),
    ),
    Destination(
      2,
      Ionicons.cart_outline,
      CartScreen(),
    ),
    Destination(
      3,
      Ionicons.person_outline,
      Container(child: AccountPage()),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 0,
          onTap: (int index) {
            setState(() {
              selectedTab = index;
            });
          },
          items: allDestinations
              .map(
                (destination) => BottomNavigationBarItem(
                  icon: Icon(
                    destination.icon,
                    color: selectedTab == destination.index
                        ? Color(0xFF97C8EB)
                        : Colors.white,
                  ),
                  label: "",
                  backgroundColor: Colors.black,
                ),
              )
              .toList(),
        ),
      ),
      body: allDestinations[selectedTab].screen,
    );
  }
}
