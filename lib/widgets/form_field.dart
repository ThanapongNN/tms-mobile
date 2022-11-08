import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget formField({
  required TextEditingController controller,
  void Function()? onTap,
  bool obscureText = false,
  bool readOnly = false,
  bool disable = false,
  double height = 10,
  int maxLength = 50,
  String hintText = '',
  String? Function(String?)? validator,
  TextInputAction textInputAction = TextInputAction.next,
  Widget? suffixIcon,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      fillColor: disable ? Colors.grey[200] : Colors.white,
      hintStyle: const TextStyle(fontSize: 18),
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
    ),
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    maxLength: maxLength,
    obscureText: obscureText,
    onTap: onTap,
    readOnly: disable ? disable : readOnly,
    style: const TextStyle(fontSize: 18),
    textInputAction: textInputAction,
    validator: validator,
  );
}
