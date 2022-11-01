import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Widget button({
  void Function()? onPressed,
  required String text,
  IconData? icon,
  bool outline = false,
}) {
  return MaterialButton(
    color: outline ? Colors.white : Colors.red,
    minWidth: double.infinity,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
      side: BorderSide(color: outline ? Colors.grey : Colors.transparent),
    ),
    onPressed: onPressed ?? () => Get.back(),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: outline ? Colors.black : Colors.white, size: 20),
      const SizedBox(width: 5),
      Text(text, style: TextStyle(color: outline ? Colors.black : Colors.white, fontWeight: FontWeight.bold)),
    ]),
  );
}
