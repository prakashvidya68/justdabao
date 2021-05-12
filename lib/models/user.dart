import 'package:flutter/widgets.dart';

// user model
class UserModel extends ChangeNotifier {
  // properties of user
  String name;
  String address;
  String email;
  String uid;

  bool isLogin = false;

  UserModel({
    this.name,
    this.address,
    this.email,
    this.uid,
  });

  changeloginStatus(bool isLogIn) {
    isLogin = isLogIn;
    notifyListeners();
  }

  updateUser({UserModel userModel}) {
    this.name = userModel.name;
    this.address = userModel.address;
    this.email = userModel.email;
    this.uid = userModel.uid;

    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'address': this.address,
      'email': this.email,
      'uid': this.uid,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      address: json["address"],
      email: json["email"],
      uid: json["uid"],
    );
  }
}
