import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tms/pages/account/account_success.dart';
import 'package:tms/pages/account/new_password.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/count_down.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/pin_code_field.dart';
import 'package:tms/widgets/text.dart';

class ConfirmOTP extends StatefulWidget {
  final String titleAppbar, titleBody;
  final bool fromDeactivateAccount;

  const ConfirmOTP({super.key, required this.titleAppbar, required this.titleBody, this.fromDeactivateAccount = false});

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
            text(widget.titleBody, fontSize: 24).paddingOnly(top: 40, bottom: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(30)),
              child: text('Ref: ABCDEFG', color: Colors.white, fontSize: 14),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              countdown(datetime: DateTime.now().add(const Duration(minutes: 3))),
            ]).paddingSymmetric(vertical: 20),
            pinCodeField(
              appContext: context,
              controller: _otp,
              errorAnimationController: errorController,
              hasError: hasError,
              onCompleted: (value) {
                if (value.length == 6) {
                  // dialog(content: 'รหัส OTP ไม่ถูกต้อง กรุณาตรวจสอบ และทำรายการใหม่');
                  // dialog(content: 'รหัส OTP หมดอายุ กรุณาขอรหัส OTP และทำรายการใหม่');
                  if (widget.fromDeactivateAccount) {
                    navigatorOffAll(
                      () => AccountSuccess(
                        titleAppbar: widget.titleAppbar,
                        titleBody: 'ระบบได้ปิดบัญชีของท่านเรียบร้อยแล้ว',
                        textButton: 'กลับสู่หน้าแรก',
                        icon: Ionicons.home_outline,
                      ),
                      transition: Transition.rightToLeft,
                    );
                  } else {
                    navigatorOff(
                      () => NewPassword(titleAppbar: widget.titleAppbar),
                      transition: Transition.rightToLeft,
                    );
                  }
                }
              },
            ),
            text(
              'ขอรหัสอีกครั้ง',
              color: ThemeColor.primaryColor,
              decoration: TextDecoration.underline,
            ).paddingAll(20),
          ]),
        ),
      ),
    );
  }
}
