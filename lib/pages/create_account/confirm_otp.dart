import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tms/pages/create_account/new_password.dart';
import 'package:tms/widgets/pin_code_field.dart';
import 'package:tms/widgets/text.dart';

class ConfirmOTP extends StatefulWidget {
  const ConfirmOTP({super.key});

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
        appBar: AppBar(title: const Text('สร้างบัญชีใหม่')),
        body: SizedBox(
          width: double.infinity,
          child: Column(children: [
            text(text: 'ยืนยันการสร้างบัญชี', fontSize: 20, fontBold: true).paddingOnly(top: 40, bottom: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(30)),
              child: text(text: 'Ref: ABCDEFG', color: Colors.white, fontSize: 14),
            ),
            Row(children: [
              Flexible(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(text: 'รหัสยืนยันการใช้งาน จะหมดอายุใน ', style: TextStyle(fontSize: 16, color: Colors.black), children: [
                    TextSpan(text: '259', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    TextSpan(text: ' นาที หลังทำกกการขอรหัส หากไม่ได้รับรหัสผ่าน กรุณากดขอรหัสผ่านใหม่อีกครั้ง')
                  ]),
                ),
              )
            ]).paddingSymmetric(horizontal: 50, vertical: 20),
            pinCodeField(
              appContext: context,
              controller: _otp,
              errorAnimationController: errorController,
              hasError: hasError,
              onCompleted: (value) {
                if (value.length == 6) {
                  Get.off(const NewPassword(), transition: Transition.rightToLeft);
                }
              },
            ),
            text(text: 'ขอรหัสอีกครั้ง', color: Colors.red, fontBold: true).paddingAll(20),
          ]),
        ),
      ),
    );
  }
}
