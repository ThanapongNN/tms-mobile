import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/text.dart';

class AccountSuccess extends StatelessWidget {
  final String titleAppbar, titleBody;
  const AccountSuccess({super.key, required this.titleAppbar, required this.titleBody});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titleAppbar)),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/create_success.jpg', scale: 2),
        FittedBox(child: text(text: titleBody, fontSize: 24).paddingSymmetric(vertical: 20)),
        button(
          text: 'เข้าสู่ระบบ',
          icon: Icons.turn_right,
          onPressed: () => Get.offAll(const LoginPage()),
        ).paddingSymmetric(horizontal: 20),
      ]).paddingSymmetric(horizontal: 20),
    );
  }
}
