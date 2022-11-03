import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Widget button({
  void Function()? onPressed,
  required String text,
  IconData? icon,
  bool outline = false,
  Color? colorOutline,
}) {
  return MaterialButton(
    height: 50,
    color: outline ? Colors.white : Colors.red,
    minWidth: double.infinity,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
      side: BorderSide(color: outline ? colorOutline ?? Colors.grey : Colors.transparent),
    ),
    onPressed: onPressed ?? () => Get.back(),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: outline ? colorOutline ?? Colors.black : Colors.white),
      const SizedBox(width: 5),
      Text(text, style: TextStyle(fontSize: 20, color: outline ? colorOutline ?? Colors.black : Colors.white)),
    ]),
  );
}
