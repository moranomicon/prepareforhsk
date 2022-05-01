import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomChoices extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color buttonColor;



  CustomChoices({required this.onPressed, required this.child,  required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        textStyle: TextStyle(fontSize: 35, color: Colors.white ),
        side: BorderSide(color: buttonColor, width: 10),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
