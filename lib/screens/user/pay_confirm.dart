import 'package:flutter/material.dart';

class PaySuccessful extends StatefulWidget {
  PaySuccessful({Key key}) : super(key: key);

  @override
  _PaySuccessfulState createState() => _PaySuccessfulState();
}

class _PaySuccessfulState extends State<PaySuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset("assets/tenor.gif"),
          ),
          Text(
            "Payment Successful",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      )),
    );
  }
}
