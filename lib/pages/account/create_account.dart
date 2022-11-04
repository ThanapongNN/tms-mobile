import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tms/pages/account/accept_terms.dart';
import 'package:tms/pages/account/confirm_otp.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/dropdown.dart';
import 'package:tms/widgets/form_field.dart';
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

  bool accept = false;
  final List<String> nameShop = ['7-11', 'Lotus HDE', 'Lotus Go Fresh', 'Lotus Talad'];
  List<bool> selectShop = [false, false, false, false];

  List<String> itemsDays = [], itemsYears = [];
  final List<String> itemsMonths = [
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม',
  ];
  final List<String> itemsJobs = ['พนักงานประจำสาขา', 'ผู้จัดการสาขา'];

  String? selectedDay, selectedMonth, selectedYear, selectedJob;

  @override
  void initState() {
    super.initState();
    itemsDays = listStringNumber(start: 1, end: 31);
    itemsYears = listStringNumber(start: (DateTime.now().year - 100), end: DateTime.now().year);
  }

  Widget checkBoxShop(int index) {
    return SizedBox(
      width: (Get.width / 2),
      child: Row(children: [
        Checkbox(
          value: selectShop[index],
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (value) {
            setState(() {
              selectShop = [false, false, false, false, false];
              selectShop[index] = value!;
            });
          },
        ),
        text(text: nameShop[index]),
      ]),
    );
  }

  List<String> listStringNumber({required int start, required int end}) {
    List<String> data = [];

    for (var i = start; i <= end; i++) {
      data.insert(0, i.toString());
    }

    return data;
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
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: text(text: 'เลือกร้านค้าปฏิบัติงาน', fontSize: 24).paddingAll(10)),
              Wrap(children: nameShop.map<Widget>((e) => checkBoxShop(nameShop.indexOf(e))).toList()).paddingSymmetric(horizontal: 20),
              Divider(thickness: 5, color: Colors.grey[200]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Center(child: text(text: 'ข้อมูลพนักงานขาย', fontSize: 24).paddingAll(10)),
                text(text: 'รหัสพนักงานขาย', fontSize: 18),
                formField(controller: _saleID, hintText: 'กรุณากรอกรหัสพนักงานขาย').paddingOnly(bottom: 10),
                text(text: 'ชื่อ', fontSize: 18),
                formField(controller: _firstName, hintText: 'กรุณากรอก').paddingOnly(bottom: 10),
                text(text: 'นามสกุล', fontSize: 18),
                formField(controller: _lastName, hintText: 'กรุณากรอก').paddingOnly(bottom: 10),
                text(text: 'วันเดือนปีเกิด', fontSize: 18),
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
                text(text: 'เบอร์มือถือ', fontSize: 18),
                formField(controller: _phoneNumber, hintText: 'กรุณากรอก').paddingOnly(bottom: 10),
                text(text: 'อีเมล', fontSize: 18),
                formField(controller: _email, hintText: 'กรุณากรอก').paddingOnly(bottom: 10),
                text(text: 'ตำแหน่งงาน', fontSize: 18),
                Row(children: [
                  dropdown(
                    hint: 'กรุณาเลือกตำแหน่งงาน',
                    items: itemsJobs,
                    selectedValue: selectedJob,
                    onChanged: (job) => setState(() => selectedJob = job as String),
                  ),
                ]).paddingOnly(bottom: 10),
                text(text: 'รหัสสาขา', fontSize: 18),
                formField(controller: _email, hintText: 'กรุณาค้นหาด้วยรหัสสาขา', suffixIcon: const Icon(Ionicons.search)).paddingOnly(bottom: 10),
                text(text: 'สาขาปฏิบัติงาน', fontSize: 18),
                formField(controller: _email, hintText: 'กรุณากรอก').paddingOnly(bottom: 10),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: ThemeColor.primaryColor,
                    side: const BorderSide(width: 2, color: Colors.grey),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: accept,
                    onChanged: (bool? v) => setState(() => accept = v!),
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
                const SizedBox(height: 20),
                button(
                  text: 'สร้างบัญชี',
                  icon: Ionicons.add,
                  onPressed: () => navigatorTo(
                    () => const ConfirmOTP(titleAppbar: 'สร้างบัญชีใหม่', titleBody: 'ยืนยันการสร้างบัญชี'),
                    transition: Transition.rightToLeft,
                  ),
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
