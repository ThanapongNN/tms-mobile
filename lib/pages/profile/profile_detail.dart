import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms/models/user_account.model.dart';
import 'package:tms/models/user_roles.model.dart';
import 'package:tms/pages/account/deactivate_account.dart';
import 'package:tms/pages/profile/profile_edit.dart';
import 'package:tms/state_management.dart';
import 'package:tms/utils/text_input_formatter.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/listtile.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  bool switchValue = true;
  String userRolesName = '';

  UserAccountModel userAccount = UserAccountModel.fromJson(Store.userProfile);
  UserRolesModel userRoles = UserRolesModel.fromJson(Store.userRoles);

  @override
  void initState() {
    super.initState();

    for (var userRole in userRoles.userRoles) {
      if (userAccount.account.roleCode == userRole.code) {
        userRolesName = userRole.name.th;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('ข้อมูลของคุณ', fontSize: 20),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(children: [
          const SizedBox(height: 20),
          CircleAvatar(
            backgroundColor: Colors.brown.shade800,
            maxRadius: 40,
            child: text(
              '${userAccount.account.name.substring(0, 1).toUpperCase()}${userAccount.account.surname.substring(0, 1).toUpperCase()}',
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 10),
          text('คุณ${userAccount.account.name} ${userAccount.account.surname}'),
          text(userAccount.account.partnerName),
          const SizedBox(height: 10),
          listTile(
            svgicon: 'assets/icons/pinlocation.svg',
            title: 'สถานที่ทำงาน',
            content: userAccount.account.partnerName,
            trailing: Column(children: [text(userAccount.account.partnerCode)]),
          ),
          listTile(svgicon: 'assets/icons/person.svg', title: 'ตำแหน่งงาน', content: userRolesName),
          listTile(
              svgicon: 'assets/icons/cake.svg',
              title: 'วันเดือนปีเกิด',
              content: DateFormat('dd MMMM ${userAccount.account.birthdate.year + 543}').format(userAccount.account.birthdate)),
          listTile(
            svgicon: 'assets/icons/phone.svg',
            title: 'เบอร์มือถือ',
            content: TextInputFormatter.maskTextPhoneNumber.maskText(userAccount.account.mobileNo),
          ),
          listTile(svgicon: 'assets/icons/envelope open.svg', title: 'อีเมล', content: userAccount.account.email),
          const Spacer(),
          button(
              text: 'แก้ไขข้อมูล',
              icon: BootstrapIcons.pencil,
              onPressed: () {
                navigatorTo((() => const ProfileEdit()));
              }),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              navigatorTo((() => const DeactivateAccount()));
            },
            child: text('ปิดบัญชีใช้งาน', color: const Color(0xFF2F80ED), decoration: TextDecoration.underline),
          ),
          const SizedBox(height: 20),
        ]).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
