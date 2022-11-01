import 'package:flutter/material.dart';

Widget formField({
  required TextEditingController controller,
  String hintText = '',
  Widget? suffixIcon,
  bool obscureText = false,
  String? Function(String?)? validator,
  double maxHeight = 30,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    validator: validator,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 14),
      suffixIcon: suffixIcon,
      constraints: BoxConstraints(maxHeight: maxHeight),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    ),
  );
}
