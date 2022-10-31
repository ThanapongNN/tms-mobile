import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/create_account/staff_information.dart';
import 'package:tms/widgets/tms_form_field.dart';
import 'package:tms/widgets/tms_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _user = TextEditingController();
  final _password = TextEditingController();

  bool _hideText = false;

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
                tmsFormField(
                  controller: _user,
                  hintText: 'รหัสพนักงานขาย',
                  validator: (user) {
                    if (user!.isEmpty) return 'กรุณาใส่รหัสพนักงานขาย';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                tmsFormField(
                  controller: _password,
                  hintText: 'รหัสผ่าน',
                  validator: (password) {
                    if (password!.isEmpty) return 'กรุณาใส่รหัสผ่าน';
                    return null;
                  },
                  obscureText: _hideText,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _hideText = !_hideText),
                    icon: Icon(
                      _hideText ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                MaterialButton(
                  height: 50,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: const BorderSide(color: Colors.white),
                  ),
                  onPressed: () {
                    Get.to(const StaffInformation());
                  },
                  child: tmsText(text: 'เข้าสู่ระบบ', color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  tmsText(text: 'ลืมรหัสผ่าน', color: Colors.white, decoration: TextDecoration.underline),
                  tmsText(text: 'สร้างบัญชีใหม่', color: Colors.white, decoration: TextDecoration.underline),
                ])
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
