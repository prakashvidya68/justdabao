import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoogleSignupButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          label: Text(
            'Sign In With Google',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          // icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
          onPressed: () {
            // final provider =
            //     Provider.of<GoogleSignInProvider>(context, listen: false);
            // provider.login();
          },
          icon: Text(
            "G",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
}
