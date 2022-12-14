import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/pages/account/confirm_otp.dart';
import 'package:tms/state_management.dart';
import 'package:tms/utils/constructor.dart';
import 'package:tms/utils/text_input_formatter.dart';
import 'package:tms/utils/validate_password.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/dialog.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class DeactivateAccount extends StatefulWidget {
  const DeactivateAccount({super.key});

  @override
  State<DeactivateAccount> createState() => _DeactivateAccountState();
}

class _DeactivateAccountState extends State<DeactivateAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _userID = TextEditingController();
  final _password = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  bool _hidePassword = true;
  bool disable = true;

  void checkAllInput() {
    if ((_userID.text.length > 6) && (_password.text.length == 8) && _formKey.currentState!.validate()) {
      disable = false;
    } else {
      disable = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('ปิดบัญชีใช้งาน')),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: text('ยืนยันการปิดบัญชีใช้งาน', fontSize: 24).paddingSymmetric(vertical: 20)),
                formField(
                  controller: _userID,
                  textLable: 'รหัสพนักงาน',
                  hintText: 'กรุณากรอกรหัสพนักงาน',
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                  inputFormatters: [TextInputFormatter.filterInputNumber],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุรหัสพนักงาน';
                    }
                    return null;
                  },
                  onChanged: (v) => setState(() => checkAllInput()),
                ),
                formField(
                  controller: _password,
                  textLable: 'รหัสผ่าน',
                  hintText: 'กรุณากรอกรหัสผ่าน',
                  obscureText: _hidePassword,
                  maxLength: 8,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [TextInputFormatter.filterInputENxNumber],
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _hidePassword = !_hidePassword),
                    icon: Icon(
                      _hidePassword ? BootstrapIcons.eye_slash : BootstrapIcons.eye_fill,
                      color: Colors.black,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุรหัสผ่าน';
                    } else if (value.length != 8) {
                      return 'กรุณาระบุรหัสผ่านจำนวน 8 หลัก';
                    } else if (!validatePassword(value)) {
                      return 'รหัสผ่านของท่านไม่ตรงตามข้อกำหนด';
                    }
                    return null;
                  },
                  onChanged: (v) => setState(() => checkAllInput()),
                ),
                const SizedBox(height: 20),
                button(
                  text: 'ยืนยัน',
                  icon: BootstrapIcons.check2_circle,
                  disable: disable,
                  onPressed: disable
                      ? () {}
                      : () async {
                          setState(() {
                            _autovalidateMode = AutovalidateMode.onUserInteraction;
                          });

                          if (_formKey.currentState!.validate()) {
                            if (Store.userAccountModel?.value.account.employee.empId == _userID.text) {
                              CallBack data = await Call.raw(
                                method: Method.post,
                                url: '$host/user/v1/token/access',
                                headers: Authorization.token,
                                body: {
                                  "deviceId": Store.deviceSerial.value,
                                  "user": _userID.text,
                                  "password": _password.text,
                                },
                                errorMessage: 'รหัสผ่านไม่ถูกต้อง กรุณากรอกใหม่อีกครั้ง',
                              );

                              if (data.success) {
                                CallBack otpRefID = await Call.raw(
                                  method: Method.post,
                                  url: '$host/support/v1/otp/request',
                                  body: {"msisdn": Store.userAccountModel?.value.account.employee.mobile},
                                );

                                Store.otpRefID.value = otpRefID.response['refId'];

                                navigatorTo(
                                  () => ConfirmOTP(
                                    otp: OTP.deactivateAccount,
                                    mobileNO: Store.userAccountModel!.value.account.employee.mobile,
                                  ),
                                  transition: Transition.rightToLeft,
                                );
                              }
                            } else {
                              dialog(content: 'รหัสพนักงานไม่ถูกต้อง กรุณากรอกใหม่อีกครั้ง');
                            }
                          } else {
                            setState(() => disable = true);
                          }
                        },
                ),
                const SizedBox(height: 10),
                button(text: 'ยกเลิก', icon: BootstrapIcons.x, outline: true),
              ],
            ).paddingSymmetric(horizontal: 60),
          ),
        ),
      ),
    );
  }
}
