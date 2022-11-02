import 'package:flutter/material.dart';

Widget text({
  required String text,
  Color? color,
  double fontSize = 20,
  TextDecoration? decoration,
  bool fontBold = false,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontBold ? FontWeight.bold : FontWeight.normal,
      decoration: decoration,
    ),
  );
}
