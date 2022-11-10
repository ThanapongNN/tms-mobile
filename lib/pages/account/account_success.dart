import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class AccountSuccess extends StatelessWidget {
  final String titleAppbar, titleBody, textButton;
  final IconData icon;

  const AccountSuccess({
    super.key,
    required this.titleAppbar,
    required this.titleBody,
    this.textButton = 'เข้าสู่ระบบ',
    this.icon = BootstrapIcons.arrow_return_right,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titleAppbar)),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset('assets/images/check_circle.svg', width: Get.width * 0.5),
        text(titleBody, fontSize: 28, textAlign: TextAlign.center).paddingSymmetric(vertical: 40, horizontal: 20),
        button(
          text: textButton,
          icon: icon,
          onPressed: () => navigatorOffAll(() => const LoginPage()),
        ).paddingSymmetric(horizontal: 40),
      ]).paddingSymmetric(horizontal: 20),
    );
  }
}
