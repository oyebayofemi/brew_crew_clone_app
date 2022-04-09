import 'package:flutter/material.dart';

InputDecoration textInputDecoration() {
  return InputDecoration(
    fillColor: Colors.grey[200],
    filled: true,
    iconColor: Colors.pink,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.brown)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.pink)),
  );
}
