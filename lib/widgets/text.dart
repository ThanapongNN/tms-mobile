import 'package:flutter/material.dart';

Widget text({
  required String text,
  Color? color,
  double fontSize = 16,
  TextDecoration? decoration,
  bool fontBold = false,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontBold ? FontWeight.bold : FontWeight.normal,
      decoration: decoration,
    ),
  );
}
