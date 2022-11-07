import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tms/pages/account/confirm_otp.dart';
import 'package:tms/utils/constructor.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/dropdown.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/list_string_number.dart';
import 'package:tms/widgets/navigator.dart';
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

  List<String> itemsDays = [], itemsYears = [];
  String? selectedDay, selectedMonth, selectedYear;

  @override
  void initState() {
    super.initState();
    itemsDays = listStringNumber(start: 1, end: 31);
    itemsYears = listStringNumber(start: ((DateTime.now().year + 543) - 100), end: (DateTime.now().year + 543), invert: true);
  }

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
              Center(child: text(text: 'กรุณาระบุข้อมูล\nเพื่อกำหนดรหัสผ่านใหม่', fontSize: 24, textAlign: TextAlign.center).paddingAll(20)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                text(text: 'รหัสพนักงานขาย'),
                formField(controller: _saleID, hintText: 'กรุณากรอกรหัสพนักงานขาย').paddingOnly(bottom: 10),
                text(text: 'ตำแหน่งงาน'),
                formField(controller: _code, hintText: 'กรุณากรอก').paddingOnly(bottom: 10),
                text(text: 'รหัสสาขา'),
                formField(controller: _job, hintText: 'กรุณากรอก').paddingOnly(bottom: 10),
                text(text: 'วันเดือนปีเกิด'),
                Row(children: [
                  dropdown(
                    flex: 2,
                    hint: 'วัน',
                    items: itemsDays,
                    selectedValue: selectedDay,
                    onChanged: (day) => setState(() => selectedDay = day as String),
                  ),
                  const SizedBox(width: 10),
                  dropdown(
                    flex: 3,
                    hint: 'เดือน',
                    items: itemsMonths,
                    selectedValue: selectedMonth,
                    onChanged: (month) => setState(() => selectedMonth = month as String),
                  ),
                  const SizedBox(width: 10),
                  dropdown(
                    flex: 3,
                    hint: 'ปี',
                    items: itemsYears,
                    selectedValue: selectedYear,
                    onChanged: (year) => setState(() => selectedYear = year as String),
                  ),
                ]).paddingOnly(bottom: 10),
                const SizedBox(height: 20),
                button(
                  text: 'ถัดไป',
                  icon: Ionicons.arrow_forward_outline,
                  onPressed: () => navigatorTo(
                    () => const ConfirmOTP(titleAppbar: 'ลืมรหัสผ่าน', titleBody: 'ยืนยันการสร้างรหัสผ่านใหม่'),
                    transition: Transition.rightToLeft,
                  ),
                ),
                const SizedBox(height: 10),
                button(text: 'ยกเลิก', icon: Ionicons.close_outline, outline: true),
              ]).paddingSymmetric(horizontal: 40)
            ]),
          ),
        ),
      ),
    );
  }
}
