import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/account/confirm_otp.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/constructor.dart';
import 'package:tms/utils/text_input_formatter.dart';
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
  final _branch = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  bool errorDay = false;
  bool errorMonth = false;
  bool errorYear = false;

  Color borderDay = Colors.grey;
  Color borderMonth = Colors.grey;
  Color borderYear = Colors.grey;

  List<String> itemsDays = [], itemsYears = [];

  String? selectedDay, selectedMonth, selectedYear;

  @override
  void initState() {
    super.initState();
    itemsDays = listStringNumber(start: 1, end: 31);
    itemsYears = listStringNumber(start: ((DateTime.now().year + 543) - 100), end: (DateTime.now().year + 543), invert: true);
  }

  bool _validateForm() {
    bool isValid = _formKey.currentState!.validate();

    setState(() {
      _autovalidateMode = AutovalidateMode.onUserInteraction;

      if (selectedDay == null) {
        borderDay = Colors.red;
        errorDay = true;
        isValid = false;
      }

      if (selectedMonth == null) {
        borderMonth = Colors.red;
        errorMonth = true;
        isValid = false;
      }

      if (selectedYear == null) {
        borderYear = Colors.red;
        errorYear = true;
        isValid = false;
      }
    });

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('ลืมรหัสผ่าน (MOCK)')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: text('กรุณาระบุข้อมูล\nเพื่อกำหนดรหัสผ่านใหม่', fontSize: 24, textAlign: TextAlign.center).paddingAll(20)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                formField(
                  controller: _saleID,
                  textLable: 'รหัสพนักงาน',
                  hintText: 'กรุณากรอกรหัสพนักงาน',
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                  inputFormatters: [TextInputFormatter.filterInputNumber],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุรหัสพนักงาน\n';
                    }
                    return null;
                  },
                ),
                formField(
                  controller: _branch,
                  textLable: 'รหัสสาขาทรู',
                  hintText: 'กรุณาค้นหาด้วยรหัสสาขาทรู',
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                  inputFormatters: [TextInputFormatter.filterInputNumber],
                  textInputAction: TextInputAction.done,
                  suffixIcon: const Icon(BootstrapIcons.search),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุรหัสสาขาทรูปฏิบัติงาน\n';
                    }
                    return null;
                  },
                ),
                Row(children: [
                  text('วันเดือนปีเกิด', fontSize: 18),
                  text('*', fontSize: 20, color: Colors.red),
                ]),
                Row(children: [
                  dropdown(
                    flex: 2,
                    hint: 'วัน',
                    items: itemsDays,
                    selectedValue: selectedDay,
                    borderColor: borderDay,
                    onChanged: (day) {
                      setState(() {
                        borderDay = Colors.grey;
                        errorDay = false;
                        selectedDay = day;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  dropdown(
                    flex: 3,
                    hint: 'เดือน',
                    items: itemsMonths,
                    selectedValue: selectedMonth,
                    borderColor: borderMonth,
                    onChanged: (month) {
                      int year = DateTime.now().year;
                      if (selectedYear != null) year = (int.parse(selectedYear!) - 543);

                      int endDay = DateTime(year, (itemsMonths.indexOf(month!) + 2), 0).day;
                      if (selectedDay != null) {
                        if (endDay < int.parse(selectedDay!)) selectedDay = endDay.toString();
                      }
                      itemsDays = listStringNumber(start: 1, end: endDay);

                      setState(() {
                        borderMonth = Colors.grey;
                        errorMonth = false;
                        selectedMonth = month;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  dropdown(
                    flex: 3,
                    hint: 'ปี',
                    items: itemsYears,
                    selectedValue: selectedYear,
                    borderColor: borderYear,
                    onChanged: (year) {
                      if (selectedMonth != null) {
                        int mouth = (itemsMonths.indexOf(selectedMonth!) + 2);
                        int endDay = DateTime((int.parse(year!) - 543), mouth, 0).day;
                        if (selectedDay != null) {
                          if (endDay < int.parse(selectedDay!)) selectedDay = endDay.toString();
                        }
                        itemsDays = listStringNumber(start: 1, end: endDay);
                      }

                      setState(() {
                        borderYear = Colors.grey;
                        errorYear = false;
                        selectedYear = year;
                      });
                    },
                  ),
                ]),
                Row(children: [
                  Expanded(
                    flex: 2,
                    child: errorDay
                        ? text('กรุณาเลือกวัน', color: ThemeColor.primaryColor, fontSize: 12).paddingOnly(left: 10)
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: errorMonth
                        ? text('กรุณาเลือกเดือน', color: ThemeColor.primaryColor, fontSize: 12).paddingOnly(left: 10)
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: errorYear
                        ? text('กรุณาเลือกปี', color: ThemeColor.primaryColor, fontSize: 12).paddingOnly(left: 10)
                        : const SizedBox.shrink(),
                  ),
                ]).paddingOnly(bottom: 10),
                const SizedBox(height: 20),
                button(
                  text: 'ถัดไป',
                  icon: BootstrapIcons.arrow_right,
                  onPressed: () {
                    if (_validateForm()) {
                      navigatorTo(
                        () => const ConfirmOTP(
                          titleAppbar: 'ลืมรหัสผ่าน',
                          titleBody: 'ยืนยันการสร้างรหัสผ่านใหม่',
                          mobileNO: '',
                        ),
                        transition: Transition.rightToLeft,
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                button(text: 'ยกเลิก', icon: BootstrapIcons.x, outline: true),
              ]).paddingSymmetric(horizontal: 40)
            ]),
          ),
        ),
      ),
    );
  }
}
