import 'package:flutter/material.dart';

Widget tmsText({
  required String text,
  Color? color,
  double fontSize = 16,
  TextDecoration? decoration,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      decoration: decoration,
    ),
  );
}
