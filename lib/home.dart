import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justdabao/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:justdabao/models/user.dart';
import 'package:justdabao/screens/customer_home.dart';
import 'package:justdabao/screens/login_screen.dart';
import 'package:justdabao/services/firestore_service.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirestoreService _db;
  @override
  void initState() {
    super.initState();
    _db = context.read(firestore);
    User currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) _db.getUserData(currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        return Center(
          child:
              (!watch(userProvider).isLogin) ? LoginScreen() : CustomerHome(),
        );
      },
    );
  }
}
