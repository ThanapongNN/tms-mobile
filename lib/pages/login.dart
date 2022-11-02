import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/account/create_account.dart';
import 'package:tms/pages/account/forget_password.dart';
import 'package:tms/pages/menu.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _user = TextEditingController();
  final _password = TextEditingController();

  bool _hideText = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          alignment: Alignment.bottomCenter,
          color: Colors.red,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                formField(
                  controller: _user,
                  hintText: 'รหัสพนักงานขาย',
                  maxHeight: double.infinity,
                  validator: (user) {
                    if (user!.isEmpty) return 'กรุณาใส่รหัสพนักงานขาย';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                formField(
                  controller: _password,
                  hintText: 'รหัสผ่าน',
                  validator: (password) {
                    if (password!.isEmpty) return 'กรุณาใส่รหัสผ่าน';
                    return null;
                  },
                  obscureText: _hideText,
                  maxHeight: double.infinity,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _hideText = !_hideText),
                    icon: FaIcon(
                      _hideText ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.solidEye,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                MaterialButton(
                  height: 70,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                    side: const BorderSide(color: Colors.white),
                  ),
                  onPressed: () => Get.to(const Menu()),
                  child: text(text: 'เข้าสู่ระบบ', color: Colors.white, fontSize: 28),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  GestureDetector(
                    onTap: () => Get.to(const ForgetPassword()),
                    child: text(text: 'ลืมรหัสผ่าน', color: Colors.white, decoration: TextDecoration.underline),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(const CreateAccount()),
                    child: text(text: 'สร้างบัญชีใหม่', color: Colors.white, decoration: TextDecoration.underline),
                  ),
                ])
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
