import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/create_account/create_success.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/text.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _saleID = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สร้างบัญชีใหม่')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: text(text: 'กำหนดรหัสผ่าน', fontSize: 20, fontBold: true).paddingSymmetric(vertical: 20)),
            text(text: 'รหัสพนักงานขาย', fontBold: true),
            formField(controller: _saleID, hintText: 'กรุณากรอกรหัสพนักงานขาย').paddingSymmetric(vertical: 10),
            text(text: 'รหัสผ่าน', fontBold: true),
            formField(controller: _password, hintText: 'กรุณากรอก').paddingSymmetric(vertical: 10),
            text(text: 'ยืนยันรหัสผ่าน', fontBold: true),
            formField(controller: _confirmPassword, hintText: 'กรุณากรอก').paddingSymmetric(vertical: 10),
            text(text: 'กรุณาตั้งรหัสผ่านกำหนด 8 หลัก ประกอบด้วยตัวเลขและตัวอักษร', color: Colors.red, fontSize: 14).paddingSymmetric(vertical: 10),
            button(
              text: 'ยืนยัน',
              icon: Icons.check,
              onPressed: () => Get.to(const CreatePassword(), transition: Transition.rightToLeft),
            ),
            button(text: 'ยกเลิก', icon: Icons.close, outline: true),
          ],
        ).paddingSymmetric(horizontal: 60),
      ),
    );
  }
}
