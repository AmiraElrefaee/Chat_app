import 'package:flutter/material.dart';

void showMassege(BuildContext context,String mesaage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mesaage,
    style: TextStyle(
        fontSize: 25
    ),
  )));
}