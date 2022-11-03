import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tms/pages/account/new_password.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/count_down.dart';
import 'package:tms/widgets/pin_code_field.dart';
import 'package:tms/widgets/text.dart';

class ConfirmOTP extends StatefulWidget {
  final String titleAppbar, titleBody;
  const ConfirmOTP({super.key, required this.titleAppbar, required this.titleBody});

  @override
  State<ConfirmOTP> createState() => _ConfirmOTPState();
}

class _ConfirmOTPState extends State<ConfirmOTP> {
  final _otp = TextEditingController();
  final errorController = StreamController<ErrorAnimationType>();
  bool hasError = false;

  @override
  void dispose() {
    super.dispose();
    errorController.close();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.titleAppbar)),
        body: SizedBox(
          width: double.infinity,
          child: Column(children: [
            text(text: widget.titleBody, fontSize: 24).paddingOnly(top: 40, bottom: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(30)),
              child: text(text: 'Ref: ABCDEFG', color: Colors.white, fontSize: 14),
            ),
            Row(children: [
              countdown(datetime: DateTime.now().add(const Duration(minutes: 3))),
            ]).paddingSymmetric(horizontal: 40, vertical: 20),
            pinCodeField(
              appContext: context,
              controller: _otp,
              errorAnimationController: errorController,
              hasError: hasError,
              onCompleted: (value) {
                if (value.length == 6) {
                  Get.off(NewPassword(titleAppbar: widget.titleAppbar), transition: Transition.rightToLeft);
                }
              },
            ),
            text(text: 'ขอรหัสอีกครั้ง', color: ThemeColor.primaryColor).paddingAll(20),
          ]),
        ),
      ),
    );
  }
}
