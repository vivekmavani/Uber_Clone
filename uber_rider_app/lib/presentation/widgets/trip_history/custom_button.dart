import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;

  CustomButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(185, 205, 237, 1),
            blurRadius: 6,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            // Color.fromRGBO(16, 16, 16, 1),
            // Color.fromRGBO(110, 82, 252, 1),
            // Color.fromRGBO(83, 145, 248, 1),

            Color.fromRGBO(251, 194, 235, 1),
            Color.fromRGBO(166, 192, 238, 1),
            Color.fromRGBO(161, 196, 253, 1),
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}