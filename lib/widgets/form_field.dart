import 'package:flutter/material.dart';

Widget formField({
  required TextEditingController controller,
  String hintText = '',
  Widget? suffixIcon,
  bool obscureText = false,
  String? Function(String?)? validator,
  double height = 10,
  void Function()? onTap,
  bool readOnly = false,
  bool disable = false,
  TextInputAction? textInputAction,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    validator: validator,
    readOnly: disable ? disable : readOnly,
    onTap: onTap,
    style: const TextStyle(fontSize: 18),
    textInputAction: textInputAction,
    decoration: InputDecoration(
      hintText: hintText,
      fillColor: disable ? Colors.grey[200] : Colors.white,
      hintStyle: const TextStyle(fontSize: 18),
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
    ),
  );
}
