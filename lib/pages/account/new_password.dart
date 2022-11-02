import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/account/account_success.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/text.dart';

class NewPassword extends StatefulWidget {
  final String titleAppbar;
  const NewPassword({super.key, required this.titleAppbar});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _saleID = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titleAppbar)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: text(
              text: 'กำหนดรหัสผ่าน',
              fontSize: 20,
            ).paddingSymmetric(vertical: 20)),
            text(
              text: 'รหัสพนักงานขาย',
            ),
            formField(controller: _saleID, hintText: 'กรุณากรอกรหัสพนักงานขาย').paddingSymmetric(vertical: 10),
            text(
              text: 'รหัสผ่าน',
            ),
            formField(controller: _password, hintText: 'กรุณากรอก').paddingSymmetric(vertical: 10),
            text(
              text: 'ยืนยันรหัสผ่าน',
            ),
            formField(controller: _confirmPassword, hintText: 'กรุณากรอก').paddingSymmetric(vertical: 10),
            text(text: 'กรุณาตั้งรหัสผ่านกำหนด 8 หลัก ประกอบด้วยตัวเลขและตัวอักษร', color: Colors.red, fontSize: 14).paddingSymmetric(vertical: 10),
            button(
              text: 'ยืนยัน',
              icon: Icons.check,
              onPressed: () => Get.to(
                AccountSuccess(
                    titleAppbar: widget.titleAppbar,
                    titleBody: (widget.titleAppbar.endsWith('ใหม่'))
                        ? 'ระบบสร้างบัญชีให้ท่านเรียบร้อยแล้ว'
                        : 'ระบบทำการเปลี่ยนรหัสผ่านให้ท่านเรียบร้อยแล้ว'),
                transition: Transition.rightToLeft,
              ),
            ),
            button(text: 'ยกเลิก', icon: Icons.close, outline: true),
          ],
        ).paddingSymmetric(horizontal: 60),
      ),
    );
  }
}
