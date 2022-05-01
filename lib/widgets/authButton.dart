
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  AuthButton({required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color:  Color(0xff4D6772),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: onPressed,
        child: Text(text,
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
