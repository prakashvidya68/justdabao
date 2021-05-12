import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:justdabao/main.dart';
import 'package:justdabao/services/firestore_service.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final ProviderReference ref;

  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  GoogleSignInProvider(this.ref) {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future<dynamic> login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      await ref.read(firestore).setUser(user);

      isSigningIn = false;

      return user;
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();

    ref.read(userProvider).updateUser(userModel: ref.read(userProvider));
    ref.read(userProvider).changeloginStatus(false);

    notifyListeners();
  }
}
