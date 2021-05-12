import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:justdabao/main.dart';
import 'package:justdabao/models/cart.dart';
import 'package:justdabao/models/restaurant.dart';
import 'package:justdabao/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirestoreService extends ChangeNotifier {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  final ProviderReference ref;

  FirestoreService(this.ref);

  // get user
  Future setUser(GoogleSignInAccount user) async {
    await _db.collection("users").doc(user.id).set({
      "name": user.displayName,
      "email": user.email,
      "uid": user.id,
      "address": ""
    });
    // print(userData.data());
    // UserModel user = UserModel.fromJson(userData.data());
    ref.read(userProvider).updateUser(
            userModel: UserModel.fromJson({
          "name": user.displayName,
          "email": user.email,
          "uid": user.id,
          "address": ""
        }));

    await getCartOnce(user.id);
    ref.read(userProvider).changeloginStatus(true);
  }

  Future getUserData(User userObj) async {
    // print("$uid");
    var userData = await _db.collection("users").doc(userObj.uid).get();
    // print(userData.data());
    if (userData.exists) {
      UserModel user = UserModel.fromJson(userData.data());
      ref.read(userProvider).updateUser(userModel: user);
    } else {
      await _db.collection("users").doc(userObj.uid).set({
        "name": userObj.displayName,
        "email": userObj.email,
        "uid": userObj.uid,
        "address": ""
      });

      ref.read(userProvider).updateUser(
              userModel: UserModel.fromJson({
            "name": userObj.displayName,
            "email": userObj.email,
            "uid": userObj.uid,
            "address": ""
          }));
    }

    await getCartOnce(userObj.uid);
    ref.read(userProvider).changeloginStatus(true);
  }

  // get all restaurants

  Future<List<Restaurant>> getAllResto(BuildContext context) async {
    var v = await _db.collection("restuarants").get();
    List<Restaurant> restos = ref.read(allResto);
    v.docs.forEach((e) async {
      // print(e.data().toString() + Random().nextInt(15).toString());
      // var orders = (await _db
      //         .collection("restuarants")
      //         .doc(e.id)
      //         .collection("orders")
      //         .get())
      //     .docs;

      // List<Order> orderList = orders.map((e) => Order.fromJson(e.data())).toList();
      if (!restos.any((el) => (el.restoId == e.data()["restoId"])))
        restos.add(Restaurant.fromJson(e.data()));
    });

    return restos;
  }

  // get the User cart

  Future<void> getCartOnce(String uid) async {
    Map<String, dynamic> cartData =
        (await _db.collection("userCart").doc(uid).get()).data();

    if (cartData != null)
      ref.read(userCartProvider).updateLocalCart(Cart.fromJson(cartData));
    else {
      ref.read(userCartProvider).updateLocalCart(Cart(
            userId: uid,
            totalCost: 0.0,
            orderProducts: [],
          ));

      addProductToCart(uid, ref.read(userCartProvider));
    }
  }

  Stream getCart(String uid) async* {
    yield _db.collection("userCart").doc(uid).get().asStream();
  }

  // create

  // update

  Future addProductToCart(String uid, Cart cart) async {
    await _db
        .collection("userCart")
        .doc(uid)
        .set(cart.toJson(), SetOptions(merge: true));
  }

  // delete

  // clear cart

  Future clearCart() async {
    await addProductToCart(
        ref.read(userProvider).uid,
        Cart(
          orderProducts: [],
        ));
  }
}
