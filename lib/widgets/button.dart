import 'package:flutter/material.dart';

Widget button({
  required void Function()? onPressed,
  IconData? icon,
  required String text,
}) {
  return MaterialButton(
    color: Colors.red,
    minWidth: double.infinity,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    onPressed: onPressed,
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: Colors.white, size: 20),
      const SizedBox(width: 5),
      Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    ]),
  );
}
