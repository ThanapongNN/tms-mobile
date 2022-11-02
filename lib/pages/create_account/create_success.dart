import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/text.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สร้างบัญชีใหม่')),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/create_success.jpg', scale: 2),
        FittedBox(
            child: text(
          text: 'ระบบสร้างบัญชีให้ท่านเรียบร้อยแล้ว',
          fontSize: 24,
        ).paddingSymmetric(vertical: 20)),
        button(
          text: 'เข้าสู่ระบบ',
          icon: Icons.turn_right,
          onPressed: () => Get.to(const LoginPage()),
        ).paddingSymmetric(horizontal: 20),
      ]).paddingSymmetric(horizontal: 20),
    );
  }
}
