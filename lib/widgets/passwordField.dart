
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PasswordField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  PasswordField({required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return TextField(
      obscureText: true,
      controller: controller,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }
}
