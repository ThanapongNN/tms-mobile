import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/constructor.dart';
import 'package:tms/utils/text_input_formatter.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/dropdown.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/list_string_number.dart';
import 'package:tms/widgets/listtile.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _partnerCode = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _email = TextEditingController();

  final List<String> itemsRoles = ['พนักงานประจำสาขา', 'ผู้จัดการสาขา'];

  List<String> itemsDays = [], itemsYears = [];

  String? selectedDay, selectedMonth, selectedYear, selectedRole;

  Color borderDay = Colors.grey;
  Color borderMonth = Colors.grey;
  Color borderYear = Colors.grey;
  Color borderRole = Colors.grey;

  bool errorRole = false;
  bool errorDay = false;
  bool errorMonth = false;
  bool errorYear = false;

  @override
  void initState() {
    super.initState();
    itemsDays = listStringNumber(start: 1, end: 31);
    itemsYears = listStringNumber(start: ((DateTime.now().year + 543) - 100), end: (DateTime.now().year + 543), invert: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('แก้ไขข้อมูล (mock)')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.red,
                backgroundImage: AssetImage('assets/images/no_avatar.png'),
              ),
              const SizedBox(height: 10),
              text('คุณ${Store.userAccountModel!.value.account.employee.name} ${Store.userAccountModel!.value.account.employee.surname}'),
              text(Store.userAccountModel!.value.account.partnerName),
              const SizedBox(height: 10),
              listTile(
                svgicon: 'assets/images/pinlocation.svg',
                title: 'สถานที่ทำงาน',
                subtitle: formField(
                  controller: _partnerCode,
                  showTextLable: false,
                  hintText: 'กรุณาค้นหาด้วยรหัสสาขาทรู',
                  suffixIcon: const Icon(BootstrapIcons.search),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุรหัสสาขาทรูปฏิบัติงาน';
                    }
                    return null;
                  },
                ),
              ),
              listTile(
                svgicon: 'assets/images/person.svg',
                title: 'ตำแหน่งงาน',
                subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    dropdown(
                      hint: 'กรุณาเลือกตำแหน่งงาน',
                      items: itemsRoles,
                      selectedValue: selectedRole,
                      borderColor: borderRole,
                      onChanged: (role) {
                        setState(() {
                          borderRole = Colors.grey;
                          errorRole = false;
                          selectedRole = role;
                        });
                      },
                    ),
                  ]),
                  if (errorRole) text('กรุณาตำแหน่งงาน', color: ThemeColor.primaryColor, fontSize: 12).paddingOnly(left: 10),
                ]).paddingOnly(bottom: 10),
              ),
              listTile(
                svgicon: 'assets/images/cake.svg',
                title: 'วันเดือนปีเกิด',
                subtitle: Row(children: [
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
              ),
              listTile(
                svgicon: 'assets/images/phone.svg',
                title: 'เบอร์มือถือ',
                subtitle: formField(
                  controller: _phoneNumber,
                  showTextLable: false,
                  hintText: 'กรุณากรอก',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [TextInputFormatter.maskTextPhoneNumber],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุเบอร์โทรศัพท์มือถือ';
                    } else if (value.length != 12) {
                      return 'กรุณาระบุเบอร์โทรศัพท์มือถือจำนวน 10 หลัก';
                    }

                    return null;
                  },
                ),
              ),
              listTile(
                svgicon: 'assets/images/envelope open.svg',
                title: 'อีเมล',
                subtitle: formField(
                  controller: _email,
                  showTextLable: false,
                  required: false,
                  hintText: 'กรุณากรอก',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      if (!EmailValidator.validate(value)) {
                        return 'กรุณาระบุอีเมลตามรูปแบบที่ถูกต้อง';
                      }
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 30),
              button(
                  text: 'ยืนยัน',
                  icon: BootstrapIcons.check2_circle,
                  onPressed: () {
                    navigatorBack();
                  }),
              const SizedBox(height: 10),
              button(text: 'ยกเลิก', icon: BootstrapIcons.x, outline: true),
            ]).paddingSymmetric(horizontal: 20),
          ),
        ),
      ),
    );
  }
}
