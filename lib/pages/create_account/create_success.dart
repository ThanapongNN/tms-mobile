import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/widgets/button.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สร้างบัญชีใหม่')),
      body: button(
        text: 'เข้าสู่ระบบ',
        onPressed: () => Get.to(const LoginPage()),
      ),
    );
  }
}
