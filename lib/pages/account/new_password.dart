import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/pages/account/account_success.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/constructor.dart';
import 'package:tms/utils/text_input_formatter.dart';
import 'package:tms/utils/validate_password.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class NewPassword extends StatefulWidget {
  final OTP otp;

  const NewPassword({super.key, required this.otp});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _userID = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  bool disable = true;

  late String titleAppbar;

  @override
  void initState() {
    super.initState();

    switch (widget.otp) {
      case OTP.createAccount:
        titleAppbar = 'สร้างบัญชีใหม่';
        _userID.text = Store.registerBody['employee']['id'];
        break;
      case OTP.forgotPassword:
        titleAppbar = 'ลืมรหัสผ่าน';
        _userID.text = Store.userID.value;
        break;
      default:
    }
  }

  void checkAllInput() {
    if ((_userID.text.length > 6) && (_password.text.length == 8) && (_confirmPassword.text.length == 8) && _formKey.currentState!.validate()) {
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
        appBar: AppBar(title: Text(titleAppbar)),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: text('กำหนดรหัสผ่าน', fontSize: 24).paddingSymmetric(vertical: 20)),
                formField(
                  disable: true,
                  controller: _userID,
                  required: false,
                  textLable: 'รหัสพนักงาน',
                ),
                formField(
                  controller: _password,
                  textLable: 'รหัสผ่าน',
                  hintText: 'กรุณากรอกรหัสผ่าน',
                  obscureText: _hidePassword,
                  maxLength: 8,
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
                formField(
                  controller: _confirmPassword,
                  textLable: 'ยืนยันรหัสผ่าน',
                  hintText: 'กรุณากรอกยืนยันรหัสผ่าน',
                  obscureText: _hideConfirmPassword,
                  maxLength: 8,
                  textInputAction: TextInputAction.done,
                  inputFormatters: [TextInputFormatter.filterInputENxNumber],
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _hideConfirmPassword = !_hideConfirmPassword),
                    icon: Icon(
                      _hideConfirmPassword ? BootstrapIcons.eye_slash : BootstrapIcons.eye_fill,
                      color: Colors.black,
                    ),
                  ),
                  validator: (value) {
                    if (value! != _password.text) {
                      return 'รหัสผ่านไม่ตรงกัน';
                    }
                    return null;
                  },
                  onChanged: (v) => setState(() => checkAllInput()),
                ),
                text('กรุณาตั้งรหัสผ่านกำหนด 8 หลัก ประกอบด้วย ตัวเลขและตัวอักษร', color: ThemeColor.primaryColor).paddingOnly(bottom: 10),
                button(
                  text: 'ยืนยัน',
                  icon: BootstrapIcons.check2_circle,
                  disable: disable,
                  onPressed: disable
                      ? () {}
                      : () {
                          setState(() {
                            _autovalidateMode = AutovalidateMode.onUserInteraction;
                          });

                          if (_formKey.currentState!.validate()) {
                            switch (widget.otp) {
                              case OTP.createAccount:
                                {
                                  Store.registerBody['employee']['password'] = _password.text;

                                  Call.raw(
                                    method: Method.post,
                                    url: '$host/user/v1/accounts/register',
                                    body: Store.registerBody,
                                    compareError: [
                                      ErrorMessage(
                                        errorMessage: 'The user was registered.',
                                        contentDialog: 'รหัสผู้ใช้งาน ${_userID.text} มีบัญชีเข้าใช้งานเรียบร้อยแล้ว',
                                      ),
                                    ],
                                  ).then((register) {
                                    if (register.success) {
                                      FirebaseAnalytics.instance.logEvent(
                                        name: 'sign_up',
                                        parameters: <String, dynamic>{
                                          "emp_id": Store.registerBody['employee']['id'],
                                          "user_name": "${Store.registerBody['employee']['name']} ${Store.registerBody['employee']['surname']}",
                                          "partner_code": Store.registerBody['partnerCode'],
                                          "partner_name": Store.registerBody['partnerName'],
                                          "create_at": "${DateTime.now()}",
                                          "role": Store.registerBody['employee']['role'],
                                          "status": 'A',
                                        },
                                      );

                                      navigatorOffAll(
                                        () => const AccountSuccess(otp: OTP.createAccount),
                                        transition: Transition.rightToLeft,
                                      );
                                    }
                                  });
                                }
                                break;
                              case OTP.forgotPassword:
                                {
                                  Call.raw(
                                    method: Method.patch,
                                    url: '$host/user/v1/accounts/${Store.forgotPasswordModel!.value.employeeId}',
                                    headers: Authorization.textPlain,
                                    body: {"password": _password.text, "status": "A"},
                                  ).then((forgotPassword) {
                                    if (forgotPassword.success) {
                                      navigatorOffAll(
                                        () => const AccountSuccess(otp: OTP.forgotPassword),
                                        transition: Transition.rightToLeft,
                                      );
                                    }
                                  });
                                }
                                break;
                              default:
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
