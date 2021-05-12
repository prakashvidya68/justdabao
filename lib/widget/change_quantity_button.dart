import 'package:flutter/material.dart';

class ProductQuantity extends StatelessWidget {
  final Function decrementQuantity;
  final Function incrementQuantity;
  final int selectedQuantity;

  ProductQuantity({
    @required this.decrementQuantity,
    @required this.incrementQuantity,
    @required this.selectedQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: decrementQuantity,
                child: Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Color(0xFFEFF0F7),
                  ),
                  child: Icon(
                    Icons.remove_rounded,
                    size: 20.0,
                    color: Color(0xFF14142B),
                  ),
                ),
              ),
              SizedBox(width: 15.0),
              Text(
                selectedQuantity.toString(),
              ),
              SizedBox(width: 15.0),
              InkWell(
                onTap: incrementQuantity,
                child: Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Color(0xFFEFF0F7),
                  ),
                  child: Icon(
                    Icons.add_rounded,
                    size: 20.0,
                    color: Color(0xFF14142B),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
