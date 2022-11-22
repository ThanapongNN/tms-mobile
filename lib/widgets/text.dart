import 'package:flutter/material.dart';

Widget text(
  String text, {
  Color? color,
  double fontSize = 16,
  TextDecoration? decoration,
  bool fontBold = false,
  TextAlign? textAlign,
  TextOverflow? overflow,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontBold ? FontWeight.bold : FontWeight.normal,
      decoration: decoration,
      overflow: overflow,
    ),
  );
}
