import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/account/account_success.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/text_input_formatter.dart';
import 'package:tms/utils/validate_password.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class ChangePassword extends StatefulWidget {
  final String titleAppbar;
  const ChangePassword({super.key, required this.titleAppbar});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _saleID = TextEditingController();
  final _oldPassword = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  bool _hideOldPassword = true;
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.titleAppbar)),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                formField(
                  controller: _saleID,
                  textLable: 'รหัสพนักงาน',
                  hintText: 'กรุณากรอกรหัสพนักงาน',
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                  inputFormatters: [TextInputFormatter.filterInputNumber],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุรหัสพนักงาน\n';
                    }
                    return null;
                  },
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
                      return 'รหัสผ่านของท่านไม่ตรงตามข้อกำหนด\n';
                    }
                    return null;
                  },
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
                    if (!validatePassword(value!)) {
                      return 'รหัสผ่านของท่านไม่ตรงตามข้อกำหนด\n';
                    }
                    return null;
                  },
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
                      return 'รหัสผ่านใหม่ของท่านไม่ตรงกัน\n';
                    }
                    return null;
                  },
                ),
                text('กรุณาตั้งรหัสผ่านกำหนด 8 หลัก ประกอบด้วย ตัวเลขและตัวอักษร', color: ThemeColor.primaryColor).paddingOnly(bottom: 10),
                button(
                  text: 'ยืนยัน',
                  icon: BootstrapIcons.check2_circle,
                  onPressed: () {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.onUserInteraction;
                    });
                    // print(_formKey.currentState!.validate());
                    navigatorOffAll(
                      () => AccountSuccess(
                        titleAppbar: widget.titleAppbar,
                        titleBody: (widget.titleAppbar.startsWith('สร้าง'))
                            ? 'ระบบสร้างบัญชีให้ท่านเรียบร้อยแล้ว'
                            : 'ระบบทำการเปลี่ยนรหัสผ่านให้ท่านเรียบร้อยแล้ว',
                      ),
                      transition: Transition.rightToLeft,
                    );
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
