import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/utils/constructor.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class AccountSuccess extends StatefulWidget {
  final OTP otp;
  const AccountSuccess({super.key, required this.otp});

  @override
  State<AccountSuccess> createState() => _AccountSuccessState();
}

class _AccountSuccessState extends State<AccountSuccess> {
  late String titleAppbar, titleBody;
  String textButton = 'เข้าสู่ระบบ';
  IconData icon = BootstrapIcons.arrow_return_right;

  @override
  void initState() {
    super.initState();

    switch (widget.otp) {
      case OTP.createAccount:
        titleAppbar = 'สร้างบัญชีใหม่';
        titleBody = 'ระบบสร้างบัญชีให้ท่านเรียบร้อยแล้ว';

        break;
      case OTP.deactivateAccount:
        titleAppbar = 'ปิดบัญชีใช้งาน';
        titleBody = 'ระบบได้ปิดบัญชีของท่านเรียบร้อยแล้ว';
        textButton = 'กลับสู่หน้าแรก';
        icon = BootstrapIcons.house;
        break;
      case OTP.forgotPassword:
        titleAppbar = 'ลืมรหัสผ่าน';
        titleBody = 'ระบบทำการเปลี่ยนรหัสผ่านให้ท่านเรียบร้อยแล้ว';
        break;
      case OTP.changePassword:
        titleAppbar = 'เปลี่ยนรหัสผ่าน';
        titleBody = 'ระบบทำการเปลี่ยนรหัสผ่านให้ท่านเรียบร้อยแล้ว';
        break;

      default:
    }
  }

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
          space: 10,
          onPressed: () => navigatorOffAll(() => const LoginPage()),
        ).paddingSymmetric(horizontal: 40),
      ]).paddingSymmetric(horizontal: 20),
    );
  }
}
