import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tms/pages/account/accept_terms.dart';
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

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _saleID = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _email = TextEditingController();
  final _branch = TextEditingController();
  final _jobBranch = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  bool accept = false;
  bool errorAccept = false;
  bool errorDay = false;
  bool errorMonth = false;
  bool errorYear = false;
  bool errorJob = false;

  bool is711 = true;

  Color borderDay = Colors.grey;
  Color borderMonth = Colors.grey;
  Color borderYear = Colors.grey;
  Color borderJob = Colors.grey;

  final List<String> nameShop = [
    '7-11',
    'Lotus HDE',
    'Lotus Go Fresh',
    'Lotus Talad',
  ];

  List<bool> selectShop = [
    true,
    false,
    false,
    false,
  ];

  List<String> itemsDays = [], itemsYears = [];

  final List<String> itemsJobs = ['พนักงานประจำสาขา', 'ผู้จัดการสาขา'];

  String? selectedDay, selectedMonth, selectedYear, selectedJob;

  @override
  void initState() {
    super.initState();
    itemsDays = listStringNumber(start: 1, end: 31);
    itemsYears = listStringNumber(start: ((DateTime.now().year + 543) - 100), end: (DateTime.now().year + 543), invert: true);
  }

  Widget checkBoxShop(int index) {
    return SizedBox(
      width: (Get.width / 2),
      child: Row(children: [
        Checkbox(
          value: selectShop[index],
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (value) {
            // setState(() {
            //   selectShop = [false, false, false, false, false];
            //   selectShop[index] = value!;
            // });
          },
        ),
        text(nameShop[index], color: index == 0 ? Colors.black : Colors.grey),
      ]),
    );
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

      if (selectedJob == null) {
        borderJob = Colors.red;
        errorJob = true;
        isValid = false;
      }

      if (!accept) {
        errorAccept = true;
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
        appBar: AppBar(title: const Text('สร้างบัญชีใหม่')),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: text('เลือกร้านค้าปฏิบัติงาน', fontSize: 24).paddingAll(10)),
              Wrap(children: nameShop.map<Widget>((e) => checkBoxShop(nameShop.indexOf(e))).toList()).paddingSymmetric(horizontal: 20),
              Divider(thickness: 5, color: Colors.grey[200]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Center(child: text('ข้อมูลพนักงานขาย', fontSize: 24).paddingAll(10)),
                formField(
                  controller: _saleID,
                  textLable: 'รหัสพนักงานขาย',
                  hintText: 'กรุณากรอกรหัสพนักงานขาย',
                  maxLength: is711 ? 7 : 8,
                  keyboardType: TextInputType.number,
                  inputFormatters: [TextInputFormatter.filterInputNumber],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุรหัสพนักงานขาย\n';
                    }
                    return null;
                  },
                ),
                formField(
                  controller: _firstName,
                  textLable: 'ชื่อ',
                  hintText: 'กรุณากรอก',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุชื่อ\n';
                    }
                    return null;
                  },
                ),
                formField(
                  controller: _lastName,
                  textLable: 'นามสกุล',
                  hintText: 'กรุณากรอก',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุนามสกุล\n';
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
                formField(
                  controller: _phoneNumber,
                  textLable: 'เบอร์มือถือ',
                  hintText: 'กรุณากรอก',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [TextInputFormatter.maskTextPhoneNumber],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุเบอร์โทรศัพท์มือถือ\n';
                    } else if (value.length != 12) {
                      return 'กรุณาระบุเบอร์โทรศัพท์มือถือจำนวน 10 หลัก\n';
                    }

                    return null;
                  },
                ),
                formField(
                  controller: _email,
                  textLable: 'อีเมล',
                  required: false,
                  hintText: 'กรุณากรอก',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      if (!EmailValidator.validate(value)) {
                        return 'กรุณาระบุอีเมลตามรูปแบบที่ถูกต้อง\n';
                      }
                    }
                    return null;
                  },
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    text('ตำแหน่งงาน', fontSize: 18),
                    text('*', fontSize: 20, color: Colors.red),
                  ]),
                  Row(children: [
                    dropdown(
                      hint: 'กรุณาเลือกตำแหน่งงาน',
                      items: itemsJobs,
                      selectedValue: selectedJob,
                      borderColor: borderJob,
                      onChanged: (job) {
                        setState(() {
                          borderJob = Colors.grey;
                          errorJob = false;
                          selectedJob = job;
                        });
                      },
                    ),
                  ]),
                  if (errorJob) text('กรุณาตำแหน่งงาน', color: ThemeColor.primaryColor, fontSize: 12).paddingOnly(left: 10),
                ]).paddingOnly(bottom: 10),
                formField(
                  controller: _branch,
                  textLable: 'รหัสสาขา',
                  hintText: 'กรุณาค้นหาด้วยรหัสสาขา',
                  suffixIcon: const Icon(Ionicons.search),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุรหัสสาขาปฏิบัติงาน\n';
                    }
                    return null;
                  },
                ),
                formField(
                  controller: _jobBranch,
                  textLable: 'สาขาปฏิบัติงาน',
                  required: false,
                  disable: true,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: ThemeColor.primaryColor,
                    side: const BorderSide(width: 2, color: Colors.grey),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: accept,
                    onChanged: (bool? v) => setState(() {
                      accept = v!;
                      errorAccept = !v;
                    }),
                    tristate: false,
                  ),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        text: 'ยอมรับเงื่อนไข ',
                        style: const TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Kanit'),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () => navigatorTo(() => const AcceptTerms()),
                            text: 'ข้อตกลงร่วมใช้และเข้าถึงข้อมูลของผู้ใช้บริการผ่านแอฟพลิเคชั้นนี้',
                            style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
                if (errorAccept)
                  text(
                    'กรุณากดยอมรับเงื่อนไข ก่อนยืนยันสร้างบัญชี',
                    color: ThemeColor.primaryColor,
                    fontSize: 12,
                  ).paddingOnly(left: 10),
                const SizedBox(height: 20),
                button(
                  text: 'สร้างบัญชี',
                  icon: Ionicons.add,
                  onPressed: () {
                    // print(_validateForm());
                    navigatorTo(
                      () => const ConfirmOTP(titleAppbar: 'สร้างบัญชีใหม่', titleBody: 'ยืนยันการสร้างบัญชี'),
                      transition: Transition.rightToLeft,
                    );
                  },
                ),
                const SizedBox(height: 10),
                button(text: 'ยกเลิก', icon: Icons.close_outlined, outline: true),
              ]).paddingSymmetric(horizontal: 40)
            ]),
          ),
        ),
      ),
    );
  }
}
