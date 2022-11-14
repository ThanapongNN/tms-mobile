import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms/pages/account/deactivate_account.dart';
import 'package:tms/pages/profile/profile_edit.dart';
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
            child: text('AH'),
          ),
          const SizedBox(height: 10),
          text('ศนันธฉัตร  ธนพัฒน์พิศาล'),
          text('7-11 สาขาเจริญนคร 27'),
          const SizedBox(height: 10),
          listTile(
            svgicon: 'assets/icons/pinlocation.svg',
            title: 'สถานที่ทำงาน',
            content: '7-11 สาขาเจริญนคร 27',
            trailing: Column(
              children: [
                text('1122334455'),
              ],
            ),
          ),
          listTile(svgicon: 'assets/icons/person.svg', title: 'ตำแหน่งงาน', content: 'พนักงานขาย'),
          listTile(svgicon: 'assets/icons/cake.svg', title: 'วันเดือนปีเกิด', content: '25 มกราคม 2540'),
          listTile(svgicon: 'assets/icons/phone.svg', title: 'เบอร์มือถือ', content: '089-980-0909'),
          listTile(svgicon: 'assets/icons/envelope open.svg', title: 'อีเมล', content: 'Sananthachat@gmail.com'),
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
