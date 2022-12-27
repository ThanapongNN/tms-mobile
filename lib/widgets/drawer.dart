import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/pages/account/change_password.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/pages/profile/profile_detail.dart';
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
        height: 230,
        width: double.infinity,
        child: DrawerHeader(
          decoration: const BoxDecoration(color: ThemeColor.primaryColor),
          child: (Store.userAccountModel != null)
              ? FittedBox(
                  child: Column(children: [
                    const CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.red,
                      backgroundImage: AssetImage('assets/images/no_avatar.png'),
                    ),
                    const SizedBox(height: 15),
                    text(
                      'คุณ${Store.userAccountModel!.value.account.employee.name} ${Store.userAccountModel!.value.account.employee.surname}',
                      color: Colors.white,
                    ),
                    text(Store.userAccountModel!.value.account.partnerName, color: Colors.white, fontSize: 16),
                  ]),
                )
              : const SizedBox(),
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
        leading: const Icon(CustomIcons.changePass, color: Colors.black, size: 28),
        title: text('เปลี่ยนรหัสผ่าน'),
        onTap: () => navigatorTo(() => const ChangePassword(), transition: Transition.leftToRight),
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
            onPressedConfirm: () async {
              CallBack data = await Call.raw(method: Method.post, url: '$host/user/v1/token/terminated', headers: Authorization.token, body: {
                "deviceId": Store.deviceSerial.value,
                "token": Store.token.value,
              });

              if (data.success) {
                Phoenix.rebirth(Get.context!);
                navigatorOffAll(() => const LoginPage());
              }
            },
          );
        },
      ).paddingSymmetric(horizontal: 20),
      text('v ${Store.version.value}', color: Colors.grey).paddingSymmetric(vertical: 10)
    ]),
  );
}
