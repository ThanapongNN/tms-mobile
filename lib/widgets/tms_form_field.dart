import 'package:flutter/material.dart';

Widget tmsFormField({
  required TextEditingController controller,
  String hintText = '',
  Widget? suffixIcon,
  bool obscureText = false,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    validator: validator,
    decoration: InputDecoration(
      hintText: hintText,
      suffixIcon: suffixIcon,
    ),
  );
}
