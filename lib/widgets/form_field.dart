import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/text.dart';

Widget formField({
  required TextEditingController controller,
  void Function()? onTap,
  bool obscureText = false,
  bool readOnly = false,
  bool disable = false,
  bool required = true,
  bool showTextLable = true,
  Color errorTextColor = ThemeColor.primaryColor,
  double height = 10,
  int maxLength = 50,
  List<TextInputFormatter>? inputFormatters,
  String hintText = '',
  String textLable = '',
  String? Function(String?)? validator,
  TextInputAction textInputAction = TextInputAction.next,
  TextInputType? keyboardType,
<<<<<<< HEAD
  Widget? suffixIcon,
  void Function(String)? onChanged,
}) {
  return Column(
    children: [
      if (showTextLable)
        Row(children: [
          text(textLable, fontSize: 18),
          if (required) text('*', fontSize: 20, color: Colors.red),
        ]),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: disable ? Colors.grey[200] : Colors.white,
          hintStyle: const TextStyle(fontSize: 18),
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
          errorStyle: TextStyle(color: errorTextColor, height: 0.6),
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        obscureText: obscureText,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: disable ? disable : readOnly,
        style: const TextStyle(fontSize: 18),
        textInputAction: textInputAction,
        validator: validator,
      ),
    ],
=======
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
>>>>>>> 4756ccbf84cd129685a427997cee3cc00c4954bd
  );
}
