import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:justdabao/main.dart';
import 'package:justdabao/models/user.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer(
        builder: (context, watchUser, _) {
          UserModel user = watchUser(userProvider);
          return SafeArea(
            minimum: EdgeInsets.all(10),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 16),
                  ),
                  Text(user.email,
                      style: Theme.of(context).textTheme.subtitle1),
                  // Text(
                  //   user.address,
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .headline1
                  //       .copyWith(fontSize: 16),
                  // ),

                  Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        onPressed: () {
                          context.read(gAuth).logout();
                        },
                        child: Text("Log Out"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
