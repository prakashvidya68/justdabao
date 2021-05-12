import 'package:flutter/material.dart';
import 'package:justdabao/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Just Dabao",
              style: Theme.of(context).textTheme.headline1,
            ),
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(border: Border.all()),
              child: TextButton(
                style: TextButton.styleFrom(),
                onPressed: () async {
                  await context.read(gAuth).login();
                },
                child: Text(
                  "Signin with google",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
