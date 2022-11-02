import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:tms/pages/account/confirm_otp.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/text.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _saleID = TextEditingController();
  final _job = TextEditingController();
  final _code = TextEditingController();
  final _birthday = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('ลืมรหัสผ่าน')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: text(text: 'กรุณาระบุข้อมูล\nเพื่อกำหนดรหัสผ่านใหม่', fontSize: 20).paddingAll(10)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                text(text: 'รหัสพนักงานขาย'),
                formField(controller: _saleID, hintText: 'กรุณากรอกรหัสพนักงานขาย').paddingSymmetric(vertical: 10),
                text(text: 'ตำแหน่งงาน'),
                formField(controller: _code, hintText: 'กรุณากรอก').paddingSymmetric(vertical: 10),
                text(text: 'รหัสสาขา'),
                formField(controller: _job, hintText: 'กรุณากรอก').paddingSymmetric(vertical: 10),
                text(text: 'วันเดือนปีเกิด'),
                formField(
                  controller: _birthday,
                  hintText: 'กรุณากรอก',
                  readOnly: true,
                  suffixIcon: const Icon(Icons.date_range, size: 20),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 100),
                      lastDate: DateTime.now(),
                      locale: Get.locale,
                    ).then((date) => _birthday.text = DateFormat('dd/MM/yyyy').format(date!));
                  },
                ).paddingSymmetric(vertical: 10),
                const SizedBox(height: 20),
                button(
                  text: 'ถัดไป',
                  icon: Icons.arrow_forward,
                  onPressed: () => Get.to(
                    const ConfirmOTP(titleAppbar: 'ลืมรหัสผ่าน', titleBody: 'ยืนยันการสร้างรหัสผ่านใหม่'),
                    transition: Transition.rightToLeft,
                  ),
                ),
                button(text: 'ยกเลิก', icon: Icons.close, outline: true),
              ]).paddingSymmetric(horizontal: 40)
            ]),
          ),
        ),
      ),
    );
  }
}
