import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tms/pages/account/create_account.dart';
import 'package:tms/pages/account/forget_password.dart';
import 'package:tms/pages/menu.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/navigator.dart';
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
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(children: [
                Image.asset('assets/images/logo.png', scale: 3),
                SizedBox(height: Get.height / 4),
                formField(
                  controller: _user,
                  hintText: 'รหัสพนักงานขาย',
                  height: 15,
                  textInputAction: TextInputAction.next,
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
                  height: 15,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _hideText = !_hideText),
                    icon: Icon(
                      _hideText ? Ionicons.eye_off_outline : Ionicons.eye,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                MaterialButton(
                  height: 60,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                    side: const BorderSide(color: Colors.white),
                  ),
                  onPressed: () => navigatorOffAll(() => const Menu()),
                  child: text(text: 'เข้าสู่ระบบ', color: Colors.white, fontSize: 24),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  GestureDetector(
                    onTap: () => navigatorTo(() => const ForgetPassword()),
                    child: text(text: 'ลืมรหัสผ่าน', color: Colors.white, decoration: TextDecoration.underline),
                  ),
                  GestureDetector(
                    onTap: () => navigatorTo(() => const CreateAccount()),
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
