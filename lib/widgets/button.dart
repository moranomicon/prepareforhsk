
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DefaultButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  DefaultButton({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: OutlinedButton(
          child: child,
          style: OutlinedButton.styleFrom(
            primary: Colors.white,
            textStyle: TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
            backgroundColor: Color(0xff4D6772),
            side: BorderSide(color: Color(0xffD7D4CC), width: 10),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          onPressed: onPressed),
    );
  }
}
