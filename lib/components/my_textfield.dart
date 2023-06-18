import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;

  const MyTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: "enter city name (eg. mumbai)"),
    );
  }
}
