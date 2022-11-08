import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tms/pages/account/account_success.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/mask_text_formatter.dart';
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
    _saleID.text = '9989979708709989';
  }

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
                      _hidePassword ? Ionicons.eye_off_outline : Ionicons.eye,
                      color: Colors.black,
                    ),
                  ),
                  validator: (value) {
                    if (!validatePassword(value!)) {
                      return 'กรุณาระบุรหัสผ่านจำนวน 8 หลัก เป็นตัวเลขและตัวอักษร\n';
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
                  inputFormatters: [TextInputFormatter.filterInputENxNumber],
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _hideConfirmPassword = !_hideConfirmPassword),
                    icon: Icon(
                      _hideConfirmPassword ? Ionicons.eye_off_outline : Ionicons.eye,
                      color: Colors.black,
                    ),
                  ),
                  validator: (value) {
                    if (value! != _password.text) {
                      return 'ยืนยันรหัสผ่านไม่ถูกต้อง กรุณาตรวจสอบ';
                    } else if (!validatePassword(value)) {
                      return 'กรุณาระบุรหัสผ่านจำนวน 8 หลัก เป็นตัวเลขและตัวอักษร\n';
                    }
                    return null;
                  },
                ),
                text('กรุณาตั้งรหัสผ่านกำหนด 8 หลัก ประกอบด้วยตัวเลขและตัวอักษร', color: ThemeColor.primaryColor).paddingOnly(bottom: 10),
                button(
                  text: 'ยืนยัน',
                  icon: FeatherIcons.checkCircle,
                  onPressed: () {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.onUserInteraction;
                    });
                    // print(_formKey.currentState!.validate());
                    navigatorTo(
                      () => AccountSuccess(
                        titleAppbar: widget.titleAppbar,
                        titleBody: (widget.titleAppbar.endsWith('ใหม่'))
                            ? 'ระบบสร้างบัญชีให้ท่านเรียบร้อยแล้ว'
                            : 'ระบบทำการเปลี่ยนรหัสผ่านให้ท่านเรียบร้อยแล้ว',
                      ),
                      transition: Transition.rightToLeft,
                    );
                  },
                ),
                const SizedBox(height: 10),
                button(text: 'ยกเลิก', icon: FeatherIcons.x, outline: true),
              ],
            ).paddingSymmetric(horizontal: 60),
          ),
        ),
      ),
    );
  }
}
