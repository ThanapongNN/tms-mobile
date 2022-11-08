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
  );
}
