import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class AccountSuccess extends StatelessWidget {
  final String titleAppbar, titleBody;
  const AccountSuccess({super.key, required this.titleAppbar, required this.titleBody});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titleAppbar)),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/check_circle.png', scale: 2),
        text(titleBody, fontSize: 24, textAlign: TextAlign.center).paddingAll(40),
        button(
          text: 'เข้าสู่ระบบ',
          icon: FeatherIcons.cornerDownRight,
          onPressed: () => navigatorOffAll(() => const LoginPage()),
        ).paddingSymmetric(horizontal: 40),
      ]).paddingSymmetric(horizontal: 20),
    );
  }
}
