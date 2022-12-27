import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/models/user_account.model.dart';
import 'package:tms/pages/account/deactivate_account.dart';
import 'package:tms/pages/no_data.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ข้อมูลของคุณ')),
      body: (Store.userAccountModel != null)
          ? SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: Column(children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.red,
                    backgroundImage: AssetImage('assets/images/no_avatar.png'),
                  ),
                  const SizedBox(height: 10),
                  text('คุณ${Store.userAccountModel!.value.account.employee.name} ${Store.userAccountModel!.value.account.employee.surname}'),
                  text(Store.userAccountModel!.value.account.employee.empId),
                  const SizedBox(height: 10),
                  listTile(
                    svgicon: 'assets/images/pinlocation.svg',
                    title: 'สถานที่ทำงาน',
                    content: Store.userAccountModel!.value.account.partnerName,
                    trailing: Column(children: [text(Store.userAccountModel!.value.account.partnerCode)]),
                  ),
                  listTile(
                      svgicon: 'assets/images/person.svg',
                      title: 'ตำแหน่งงาน',
                      content: Store.userAccountModel!.value.account.employee.roleName.nameTh),
                  listTile(
                      svgicon: 'assets/images/cake.svg',
                      title: 'วันเดือนปีเกิด',
                      content: DateFormat('dd MMMM ${Store.userAccountModel!.value.account.employee.birthdate.year + 543}')
                          .format(Store.userAccountModel!.value.account.employee.birthdate)),
                  listTile(
                    svgicon: 'assets/images/phone.svg',
                    title: 'เบอร์มือถือ',
                    content: TextInputFormatter.maskTextPhoneNumber.maskText(Store.userAccountModel!.value.account.employee.mobile),
                  ),
                  listTile(svgicon: 'assets/images/envelope open.svg', title: 'อีเมล', content: Store.userAccountModel!.value.account.employee.email),
                  // const Spacer(),
                  button(
                    text: 'แก้ไขข้อมูล',
                    icon: BootstrapIcons.pencil,
                    onPressed: () {
                      navigatorTo((() => const ProfileEdit()));
                    },
                  ),
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
            )
          : NoDataPage(
              onPressed: () {
                Call.raw(
                  method: Method.get,
                  url: '$host/user/v1/accounts/${Store.encryptedEmployeeId.value}',
                  headers: Authorization.token,
                  showDialog: false,
                  showLoading: false,
                ).then((userAccount) {
                  if (userAccount.success) Store.userAccountModel = UserAccountModel.fromJson(userAccount.response).obs;
                  setState(() {});
                });
              },
            ),
    );
  }
}
