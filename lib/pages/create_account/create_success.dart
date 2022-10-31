import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/widgets/tms_button.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สร้างบัญชีใหม่')),
      body: tmsButton(
        text: 'เข้าสู่ระบบ',
        onPressed: () => Get.to(const LoginPage()),
      ),
    );
  }
}
