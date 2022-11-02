import 'package:flutter/material.dart';

Widget formField({
  required TextEditingController controller,
  String hintText = '',
  Widget? suffixIcon,
  bool obscureText = false,
  String? Function(String?)? validator,
  double maxHeight = 30,
  void Function()? onTap,
  bool readOnly = false,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    validator: validator,
    readOnly: readOnly,
    onTap: onTap,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 14),
      suffixIcon: suffixIcon,
      constraints: BoxConstraints(maxHeight: maxHeight),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    ),
  );
}
