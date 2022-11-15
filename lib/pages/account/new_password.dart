import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/apis/api.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/pages/account/account_success.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/text_input_formatter.dart';
import 'package:tms/utils/validate_password.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class NewPassword extends StatefulWidget {
  final String titleAppbar;
  const NewPassword({super.key, required this.titleAppbar});

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

  @override
  void initState() {
    super.initState();
    _saleID.text = Store.registerBody['employee']['id'];
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
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
                Center(child: text('กำหนดรหัสผ่าน', fontSize: 24).paddingSymmetric(vertical: 20)),
                formField(
                  disable: true,
                  controller: _saleID,
                  required: false,
                  textLable: 'รหัสพนักงานขาย',
                  hintText: 'กรุณากรอกรหัสพนักงานขาย',
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
                    if (!validatePassword(value!)) {
                      return 'รหัสผ่านของท่านไม่ตรงตามข้อกำหนด\n';
                    }
                    return null;
                  },
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
                ),
                text('กรุณาตั้งรหัสผ่านกำหนด 8 หลัก ประกอบด้วย ตัวเลขและตัวอักษร', color: ThemeColor.primaryColor).paddingOnly(bottom: 10),
                button(
                  text: 'ยืนยัน',
                  icon: BootstrapIcons.check2_circle,
                  onPressed: () async {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.onUserInteraction;
                    });

                    if (_formKey.currentState!.validate()) {
                      Store.registerBody['employee']['password'] = _password.text;

                      CallBack data = await API.call(
                        method: Method.post,
                        url: '$hostDev/user/v1/accounts/register',
                        headers: Authorization.none,
                        body: Store.registerBody,
                      );

                      if (data.success) {
                        navigatorOffAll(
                          () => AccountSuccess(
                            titleAppbar: widget.titleAppbar,
                            titleBody: (widget.titleAppbar.endsWith('ใหม่'))
                                ? 'ระบบสร้างบัญชีให้ท่านเรียบร้อยแล้ว'
                                : 'ระบบทำการเปลี่ยนรหัสผ่านให้ท่านเรียบร้อยแล้ว',
                          ),
                          transition: Transition.rightToLeft,
                        );
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
