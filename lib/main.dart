import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:justdabao/home.dart';
import 'package:justdabao/models/cart.dart';
import 'package:justdabao/models/restaurant.dart';
import 'package:justdabao/screens/user/cart_screen.dart';
import 'package:justdabao/screens/user/explore/restuarant_menu.dart';
import 'package:justdabao/services/firebase_google_auth.dart';
import 'package:justdabao/models/user.dart';
import 'package:justdabao/services/firestore_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

final gAuth = ChangeNotifierProvider((ref) => GoogleSignInProvider(ref));
final firestore = ChangeNotifierProvider((ref) => FirestoreService(ref));
final userProvider = ChangeNotifierProvider((ref) => UserModel());
final allResto = Provider((ref) => <Restaurant>[]);
final userCartProvider = Provider((ref) => Cart(ref: ref));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xFFF9F9F9),
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color(0xFFB0BBBF),
        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w800,
            fontSize: 25,
            color: Colors.black87,
          ),
          headline2: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w800,
            fontSize: 14,
            color: Colors.red,
          ),
          bodyText1: TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            color: Colors.black87,
          ),
          bodyText2: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            color: Colors.black87,
          ),
          button: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          subtitle1: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        // appBarTheme: AppBarTheme(
        //   iconTheme: IconThemeData(color: Colors.black),
        // ),
      ),
      home: MyHomePage(),
      routes: {
        RestoMenu.routeName: (context) => RestoMenu(),
        CartScreen.routeName: (context) => CartScreen(),
      },
    );
  }
}
