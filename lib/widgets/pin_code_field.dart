import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tms/theme/color.dart';

Widget pinCodeField({
  required BuildContext appContext,
  TextEditingController? controller,
  StreamController<ErrorAnimationType>? errorAnimationController,
  bool hasError = false,
  void Function(String)? onCompleted,
}) {
  return PinCodeTextField(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    appContext: appContext,
    pastedTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    length: 6,
    obscureText: false,
    obscuringCharacter: '*',
    animationType: AnimationType.fade,
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(5),
      fieldHeight: 50,
      fieldWidth: 43,
      activeColor: hasError ? ThemeColor.primaryColor : Colors.white,
      selectedColor: ThemeColor.primaryColor,
      inactiveColor: Colors.grey[300],
      disabledColor: Colors.grey[300],
      activeFillColor: Colors.white,
      selectedFillColor: Colors.white,
      inactiveFillColor: Colors.white,
    ),
    cursorColor: Colors.black,
    animationDuration: const Duration(milliseconds: 300),
    textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    backgroundColor: Colors.white,
    enableActiveFill: true,
    errorAnimationController: errorAnimationController,
    controller: controller,
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    boxShadows: const [BoxShadow(offset: Offset(0, 1), color: Colors.black12, blurRadius: 10)],
    beforeTextPaste: (text) => true,
    onChanged: (value) {},
    onCompleted: onCompleted,
  );
}
