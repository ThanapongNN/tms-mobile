import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/create_account/create_success.dart';
import 'package:tms/widgets/tms_button.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สร้างบัญชีใหม่')),
      body: tmsButton(
        text: 'ยืนยัน',
        onPressed: () => Get.to(const CreatePassword(), transition: Transition.rightToLeft),
      ),
    );
  }
}
