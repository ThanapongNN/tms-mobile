import 'package:flutter/material.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/navigator.dart';

Widget button({
  void Function()? onPressed,
  required String text,
  IconData? icon,
  bool outline = false,
  Color? colorOutline,
  double space = 5,
}) {
  return MaterialButton(
    height: 50,
    color: outline ? Colors.white : ThemeColor.primaryColor,
    minWidth: double.infinity,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
      side: BorderSide(color: outline ? colorOutline ?? Colors.grey : Colors.transparent),
    ),
    onPressed: onPressed ?? () => navigatorBack(),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: outline ? colorOutline ?? Colors.black : Colors.white, size: 32),
      SizedBox(width: space),
      Text(text, style: TextStyle(fontSize: 24, color: outline ? colorOutline ?? Colors.black : Colors.white)),
    ]),
  );
}
