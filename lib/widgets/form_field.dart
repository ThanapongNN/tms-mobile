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
  int maxLength = 100,
  List<TextInputFormatter>? inputFormatters,
  String hintText = '',
  String textLable = '',
  String? prefixText,
  String? Function(String?)? validator,
  TextInputAction textInputAction = TextInputAction.next,
  TextInputType? keyboardType,
  Widget? suffixIcon,
  void Function(String)? onChanged,
  bool radius = false,
  Widget? prefixIcon,
  BoxConstraints? prefixIconConstraints,
}) {
  return Column(children: [
    if (showTextLable)
      Row(children: [
        text(textLable, fontSize: 18),
        text('*', fontSize: 20, color: required ? Colors.red : Colors.white),
      ]),
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
        errorMaxLines: 3,
        hintText: hintText,
        fillColor: disable ? Colors.grey[200] : Colors.white,
        hintStyle: const TextStyle(fontSize: 18),
        prefixIcon: prefixIcon,
        prefixIconConstraints: prefixIconConstraints,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
        errorStyle: TextStyle(color: errorTextColor),
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
      onChanged: onChanged,
      onTap: onTap,
      readOnly: disable ? disable : readOnly,
      style: const TextStyle(fontSize: 18),
      textInputAction: textInputAction,
      validator: validator,
    ),
  ]);
}
