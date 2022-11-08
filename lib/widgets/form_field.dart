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
  bool radius = false,
  Widget? prefixIcon,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      hintText: hintText,
      fillColor: disable ? Colors.grey[200] : Colors.white,
      hintStyle: const TextStyle(fontSize: 18),
      suffixIcon: suffixIcon,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      border: radius
          ? const OutlineInputBorder(
              borderRadius: BorderRadius.all((Radius.circular(50))),
            )
          : null,
      enabledBorder: radius
          ? const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            )
          : null,
      focusedBorder: radius
          ? const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            )
          : null,
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
