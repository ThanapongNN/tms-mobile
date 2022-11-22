import 'package:bootstrap_icons/bootstrap_icons.dart';
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

  final _saleID = TextEditingController();
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
        _saleID.text = Store.registerBody['employee']['id'];
        break;
      case OTP.forgotPassword:
        titleAppbar = 'ลืมรหัสผ่าน';
        _saleID.text = Store.saleID.value;
        break;
      default:
    }
  }

  void checkAllInput() {
    if (_saleID.text.isNotEmpty && _password.text.isNotEmpty && _confirmPassword.text.isNotEmpty) {
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
                  controller: _saleID,
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
                      return 'กรุณาระบุรหัสผ่าน\n';
                    } else if (value.length != 8) {
                      return 'กรุณาระบุรหัสผ่านจำนวน 8 หลัก\n';
                    } else if (!validatePassword(value)) {
                      return 'รหัสผ่านของท่านไม่ตรงตามข้อกำหนด\n';
                    }
                    return null;
                  },
                  onChanged: (v) => checkAllInput(),
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
                      return 'รหัสผ่านไม่ตรงกัน\n';
                    }
                    return null;
                  },
                  onChanged: (v) => checkAllInput(),
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
                                    url: '$hostTrue/user/v1/accounts/register',
                                    headers: Authorization.none,
                                    body: Store.registerBody,
                                    compareError: [
                                      ErrorMessage(
                                        errorMessage: 'The user was registered.',
                                        contentDialog: 'รหัสผู้ใช้งาน ${_saleID.text} มีบัญชีเข้าใช้งานเรียบร้อยแล้ว',
                                      ),
                                    ],
                                  ).then((register) {
                                    if (register.success) {
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
                                    url: '$hostTrue/user/v1/accounts/${Store.forgotPasswordModel.value.employeeId}',
                                    headers: Authorization.none,
                                    body: {"password": _password.text},
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
