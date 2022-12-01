import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/pages/account/account_success.dart';
import 'package:tms/pages/account/new_password.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/constructor.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class ConfirmOTP extends StatefulWidget {
  final String mobileNO;
  final OTP otp;

  const ConfirmOTP({super.key, required this.mobileNO, required this.otp});

  @override
  State<ConfirmOTP> createState() => _ConfirmOTPState();
}

class _ConfirmOTPState extends State<ConfirmOTP> {
  final _otp = TextEditingController();
  late StreamController<ErrorAnimationType> errorController;

  DateTime countDown = DateTime.now();

  late String titleAppbar, titleBody;

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();

    switch (widget.otp) {
      case OTP.createAccount:
        titleAppbar = 'สร้างบัญชีใหม่';
        titleBody = 'ยืนยันการสร้างบัญชี';
        break;
      case OTP.deactivateAccount:
        titleAppbar = 'ปิดบัญชีใช้งาน';
        titleBody = 'ยืนยันการปิดบัญชี';
        break;
      case OTP.forgotPassword:
        titleAppbar = 'ลืมรหัสผ่าน';
        titleBody = 'ยืนยันการสร้างรหัสผ่านใหม่';
        break;
      default:
    }
  }

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
        appBar: AppBar(title: Text(titleAppbar)),
        body: SizedBox(
          width: double.infinity,
          child: Column(children: [
            text(titleBody, fontSize: 24).paddingOnly(top: 40, bottom: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(30)),
              child: text('Ref: ${Store.otpRefID.value}', color: Colors.white, fontSize: 14),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CountdownTimer(
                endTime: countDown.millisecondsSinceEpoch + 1000 * 180,
                widgetBuilder: (context, time) {
                  if (time == null) {
                    return text('รหัส OTP หมดอายุ กรุณาขอรหัส OTP และทำรายการใหม่', color: ThemeColor.primaryColor);
                  }
                  return Flexible(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'รหัสยืนยันการใช้งาน จะหมดอายุใน ',
                        style: const TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Kanit'),
                        children: [
                          TextSpan(
                            text: '0${time.min} : ${time.sec.toString().padLeft(2, '0')}',
                            style: const TextStyle(color: ThemeColor.primaryColor, fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: ' นาที\nหลังทำการขอรหัส หากไม่ได้รับรหัสผ่าน\nกรุณากดขอรหัสผ่านใหม่อีกครั้ง')
                        ],
                      ),
                    ),
                  );
                },
              ),
            ]).paddingSymmetric(vertical: 20),
            PinCodeTextField(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              appContext: context,
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
                activeColor: Colors.white,
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
              errorAnimationController: errorController,
              controller: _otp,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              boxShadows: const [BoxShadow(offset: Offset(0, 1), color: Colors.black12, blurRadius: 10)],
              beforeTextPaste: (text) => true,
              onChanged: (value) {},
              onCompleted: (value) {
                Call.raw(
                  method: Method.post,
                  url: '$hostTrue/support/v1/otp/validation',
                  body: {"msisdn": widget.mobileNO, "refId": Store.otpRefID.value, "otp": _otp.text},
                  errorMessage: 'รหัส OTP ไม่ถูกต้อง กรุณาตรวจสอบ และทำรายการใหม่',
                ).then((otp) {
                  if (otp.success) {
                    switch (widget.otp) {
                      case OTP.createAccount:
                        {
                          Store.registerBody['otpRefId'] = Store.otpRefID.value;
                          navigatorOff(
                            () => const NewPassword(otp: OTP.createAccount),
                            transition: Transition.rightToLeft,
                          );
                        }
                        break;
                      case OTP.deactivateAccount:
                        {
                          Call.raw(
                            method: Method.delete,
                            url: '$hostTrue/user/v1/accounts/${Store.userAccountModel?.value.account.employee.id}',
                            headers: Authorization.token,
                          ).then((deactivateAccount) {
                            if (deactivateAccount.success) {
                              navigatorOffAll(
                                () => const AccountSuccess(otp: OTP.deactivateAccount),
                                transition: Transition.rightToLeft,
                              );
                            }
                          });
                        }
                        break;
                      case OTP.forgotPassword:
                        {
                          navigatorOff(
                            () => const NewPassword(otp: OTP.forgotPassword),
                            transition: Transition.rightToLeft,
                          );
                        }
                        break;
                      default:
                    }
                  } else {
                    errorController.add(ErrorAnimationType.shake);
                  }
                });
              },
            ),
            GestureDetector(
              onTap: () {
                Call.raw(
                  method: Method.post,
                  url: '$hostTrue/support/v1/otp/request',
                  body: {"msisdn": widget.mobileNO},
                ).then((otp) {
                  if (otp.success) {
                    Store.otpRefID.value = otp.response['refId'];
                    setState(() => countDown = DateTime.now());
                  }
                });
              },
              child: text(
                'ขอรหัสอีกครั้ง',
                color: ThemeColor.primaryColor,
                decoration: TextDecoration.underline,
              ).paddingAll(20),
            ),
          ]),
        ),
      ),
    );
  }
}
