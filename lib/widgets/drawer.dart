import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/account/change_password.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/pages/profile/profile_detail.dart';
import 'package:tms/pages/setting.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/custom_icons_icons.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/dialog.dart';
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
              child: text('AH'),
            ),
            // const SizedBox(height: 5),
            // GestureDetector(
            //   onTap: () {},
            //   child: text('แก้ไขรูป', color: Colors.white, fontSize: 16, decoration: TextDecoration.underline),
            // ),
            const SizedBox(height: 15),
            text('คุณศนันธฉัตร  ธนพัฒน์พิศาล', color: Colors.white),
            text('7-11 สาขาเจริญนคร 27', color: Colors.white, fontSize: 16),
          ]),
        ),
      ),
      ListTile(
        horizontalTitleGap: 0,
        leading: const Icon(CustomIcons.profile, color: Colors.black),
        title: text('ข้อมูลของคุณ'),
        onTap: () => navigatorTo(() => const ProfileDetail(), transition: Transition.leftToRight),
      ),
      const Divider(),
      ListTile(
        horizontalTitleGap: 0,
        leading: const Icon(CustomIcons.change_pass, color: Colors.black, size: 28),
        title: text('เปลี่ยนรหัสผ่าน'),
        onTap: () => navigatorTo(() => const ChangePassword(titleAppbar: 'เปลี่ยนรหัสผ่าน'), transition: Transition.leftToRight),
      ),
      const Divider(),
      // ListTile(
      //   minLeadingWidth: 20,
      //   leading: const Icon(Icons.settings),
      //   title: text('ตั้งค่า'),
      //   onTap: () => navigatorTo(() => const Setting(), transition: Transition.leftToRight),
      // ),
      const Spacer(),
      button(
        icon: CustomIcons.logout,
        text: 'ออกจากระบบ',
        outline: true,
        space: 15,
        colorOutline: ThemeColor.primaryColor,
        onPressed: () {
          dialog(
            content: 'คุณต้องการออกจากระบบ',
            onPressedConfirm: () => navigatorOffAll(() => const LoginPage()),
          );
        },
      ).paddingSymmetric(horizontal: 20),
      text('v ${Store.version.value}', color: Colors.grey).paddingSymmetric(vertical: 10)
    ]),
  );
}
