import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/models/forgot_password.model.dart';
import 'package:tms/models/user_roles.model.dart';
import 'package:tms/pages/account/confirm_otp.dart';
import 'package:tms/state_management.dart';
import 'package:tms/utils/constructor.dart';
import 'package:tms/utils/text_input_formatter.dart';
import 'package:tms/utils/validate_thai_national_id.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _saleID = TextEditingController();
  final _thaiID = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  bool disable = true;

  UserRolesModel user = UserRolesModel.fromJson(Store.userRoles);

  bool _validateForm() {
    bool isValid = _formKey.currentState!.validate();

    setState(() {
      _autovalidateMode = AutovalidateMode.onUserInteraction;
    });

    return isValid;
  }

  void checkAllInput() {
    if ((_saleID.text.length > 6) && (_thaiID.text.length == 17)) {
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
        appBar: AppBar(title: const Text('ลืมรหัสผ่าน')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: text('กรุณาระบุข้อมูล\nเพื่อกำหนดรหัสผ่านใหม่', fontSize: 24, textAlign: TextAlign.center).paddingAll(20)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                formField(
                  controller: _saleID,
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
                  controller: _thaiID,
                  textLable: 'เลขบัตรประชาชน',
                  hintText: 'กรุณากรอกเลขบัตรประชาชน',
                  maxLength: 17,
                  keyboardType: TextInputType.number,
                  inputFormatters: [TextInputFormatter.maskTextIDCardTH],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุเลขบัตรประชาชน';
                    } else if ((value.length != 17) || !validateThaiNationalID(value.replaceAll('-', ''))) {
                      return 'เลขบัตรประชาชนไม่ถูกต้อง';
                    }
                    return null;
                  },
                  onChanged: (v) => setState(() => checkAllInput()),
                ),
                const SizedBox(height: 20),
                button(
                  text: 'ถัดไป',
                  icon: BootstrapIcons.arrow_right,
                  disable: disable,
                  onPressed: disable
                      ? () {}
                      : () async {
                          if (_validateForm()) {
                            Store.saleID.value = _saleID.text;

                            Call.raw(
                              method: Method.post,
                              url: '$host/user/v1/accounts/${_saleID.text}',
                              body: {"thai_id": _thaiID.text.replaceAll('-', '')},
                            ).then((forgotPassword) {
                              if (forgotPassword.success) {
                                Store.forgotPasswordModel = ForgotPasswordModel.fromJson(forgotPassword.response).obs;

                                Call.raw(
                                  method: Method.post,
                                  url: '$host/support/v1/otp/request',
                                  body: {"msisdn": Store.forgotPasswordModel!.value.mobile},
                                ).then((otp) {
                                  if (otp.success) {
                                    Store.otpRefID.value = otp.response['refId'];
                                    navigatorTo(
                                      () => ConfirmOTP(
                                        otp: OTP.forgotPassword,
                                        mobileNO: Store.forgotPasswordModel!.value.mobile,
                                      ),
                                      transition: Transition.rightToLeft,
                                    );
                                  }
                                });
                              }
                            });
                          } else {
                            setState(() => disable = true);
                          }
                        },
                ),
                const SizedBox(height: 10),
                button(text: 'ยกเลิก', icon: BootstrapIcons.x, outline: true),
              ]).paddingSymmetric(horizontal: 40)
            ]),
          ),
        ),
      ),
    );
  }
}
