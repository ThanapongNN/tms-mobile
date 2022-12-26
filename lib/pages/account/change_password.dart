import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/account/account_success.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/constructor.dart';
import 'package:tms/utils/text_input_formatter.dart';
import 'package:tms/utils/validate_password.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _userID = TextEditingController();
  final _oldPassword = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  bool _hideOldPassword = true;
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  bool disable = true;

  void checkAllInput() {
    if ((_userID.text.length > 6) &&
        (_oldPassword.text.length == 8) &&
        (_password.text.length == 8) &&
        (_confirmPassword.text.length == 8) &&
        _formKey.currentState!.validate()) {
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
        appBar: AppBar(title: const Text('เปลี่ยนรหัสผ่าน (mock)')),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
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
                  controller: _oldPassword,
                  textLable: 'รหัสผ่านเดิม',
                  hintText: 'กรุณากรอกรหัสผ่านเดิม',
                  obscureText: _hideOldPassword,
                  maxLength: 8,
                  inputFormatters: [TextInputFormatter.filterInputENxNumber],
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _hideOldPassword = !_hideOldPassword),
                    icon: Icon(
                      _hideOldPassword ? BootstrapIcons.eye_slash : BootstrapIcons.eye_fill,
                      color: Colors.black,
                    ),
                  ),
                  validator: (value) {
                    if (!validatePassword(value!)) {
                      return 'รหัสผ่านของท่านไม่ตรงตามข้อกำหนด';
                    }
                    return null;
                  },
                  onChanged: (v) => setState(() => checkAllInput()),
                ),
                formField(
                  controller: _password,
                  textLable: 'รหัสผ่านใหม่',
                  hintText: 'กรุณากรอกรหัสผ่านใหม่',
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
                    if (value == _oldPassword.text) {
                      return 'ไม่สามารถกำหนดรหัสผ่านใหม่ตรงกับรหัสผ่านปัจจุบันได้';
                    } else if (!validatePassword(value!)) {
                      return 'รหัสผ่านของท่านไม่ตรงตามข้อกำหนด';
                    }
                    return null;
                  },
                  onChanged: (v) => setState(() => checkAllInput()),
                ),
                formField(
                  controller: _confirmPassword,
                  textLable: 'ยืนยันรหัสผ่านใหม่',
                  hintText: 'กรุณากรอกยืนยันรหัสผ่านใหม่',
                  obscureText: _hideConfirmPassword,
                  maxLength: 8,
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
                      return 'รหัสผ่านใหม่ของท่านไม่ตรงกัน';
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
                            navigatorOffAll(
                              () => const AccountSuccess(otp: OTP.changePassword),
                              transition: Transition.rightToLeft,
                            );
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
