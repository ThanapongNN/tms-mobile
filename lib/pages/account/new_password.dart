import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/account/account_success.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/navigator.dart';
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
  void initState() {
    super.initState();
    _saleID.text = '9989979708709989';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titleAppbar)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: text(text: 'กำหนดรหัสผ่าน', fontSize: 24).paddingSymmetric(vertical: 20)),
            text(text: 'รหัสพนักงานขาย', fontSize: 18),
            formField(disable: true, controller: _saleID, hintText: 'กรุณากรอกรหัสพนักงานขาย').paddingOnly(bottom: 10),
            text(text: 'รหัสผ่าน', fontSize: 18),
            formField(controller: _password, hintText: 'กรุณากรอกรหัสผ่าน').paddingOnly(bottom: 10),
            text(text: 'ยืนยันรหัสผ่าน', fontSize: 18),
            formField(controller: _confirmPassword, hintText: 'กรุณากรอกยืนยันรหัสผ่าน').paddingOnly(bottom: 10),
            text(
              text: 'กรุณาตั้งรหัสผ่านกำหนด 8 หลัก ประกอบด้วยตัวเลขและตัวอักษร',
              color: ThemeColor.primaryColor,
            ).paddingOnly(bottom: 10),
            button(
              text: 'ยืนยัน',
              icon: FeatherIcons.checkCircle,
              onPressed: () => navigatorTo(
                () => AccountSuccess(
                    titleAppbar: widget.titleAppbar,
                    titleBody: (widget.titleAppbar.endsWith('ใหม่'))
                        ? 'ระบบสร้างบัญชีให้ท่านเรียบร้อยแล้ว'
                        : 'ระบบทำการเปลี่ยนรหัสผ่านให้ท่านเรียบร้อยแล้ว'),
                transition: Transition.rightToLeft,
              ),
            ),
            const SizedBox(height: 10),
            button(text: 'ยกเลิก', icon: FeatherIcons.x, outline: true),
          ],
        ).paddingSymmetric(horizontal: 60),
      ),
    );
  }
}
