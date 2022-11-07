import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

Widget drawer() {
  return Drawer(
    child: Column(children: <Widget>[
      SizedBox(
        height: 240,
        width: double.infinity,
        child: DrawerHeader(
          decoration: const BoxDecoration(color: ThemeColor.primaryColor),
          child: Column(children: [
            CircleAvatar(
              backgroundColor: Colors.brown.shade800,
              maxRadius: 35,
              child: text(text: 'AH'),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {},
              child: text(text: 'แก้ไขรูป', color: Colors.white, fontSize: 16, decoration: TextDecoration.underline),
            ),
            const SizedBox(height: 15),
            text(text: 'ศนันธฉัตร  ธนพัฒน์พิศาล', color: Colors.white),
            text(text: '7-11 สาขาเจริญนคร 27', color: Colors.white, fontSize: 16),
          ]),
        ),
      ),
      ListTile(
        minLeadingWidth: 20,
        leading: const Icon(Icons.account_circle),
        title: text(text: 'ข้อมูลของคุณ'),
      ),
      ListTile(
        minLeadingWidth: 20,
        leading: const Icon(Icons.sync_lock),
        title: text(text: 'เปลี่ยนรหัสผ่าน'),
      ),
      ListTile(
        minLeadingWidth: 20,
        leading: const Icon(Icons.settings),
        title: text(text: 'ตั้งค่า'),
      ),
      const Spacer(),
      button(
        icon: Icons.exit_to_app,
        text: 'ออกจากระบบ',
        outline: true,
        colorOutline: ThemeColor.primaryColor,
        onPressed: () => navigatorOffAll(() => const LoginPage()),
      ).paddingSymmetric(horizontal: 40),
      text(text: 'v ${Store.version.value}', color: Colors.grey).paddingSymmetric(vertical: 10)
    ]),
  );
}
