
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  EmailField({required this.controller});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

    return TextField(
      obscureText: false,

      style: style,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          fillColor: Colors.white,
          filled: true,
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }
}
