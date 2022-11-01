import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/create_account/confirm_otp.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/dropdown.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/text.dart';

class StaffInformation extends StatefulWidget {
  const StaffInformation({super.key});

  @override
  State<StaffInformation> createState() => _StaffInformationState();
}

class _StaffInformationState extends State<StaffInformation> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _saleID = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _email = TextEditingController();

  bool accept = false;
  final List<String> nameShop = ['7-11', 'Lotus HDE', 'Lotus Go Fresh', 'Lotus Talad', 'CP Frash Mart'];
  List<bool> selectShop = [false, false, false, false, false];

  List<String> itemsDays = [];
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
  List<String> itemsYears = [];

  String? selectedDay, selectedMonth, selectedYear;

  @override
  void initState() {
    super.initState();
    itemsDays = listStringNumber(start: 1, end: 31);
    itemsYears = listStringNumber(start: (DateTime.now().year - 100), end: DateTime.now().year);
  }

  Widget checkBoxShop(int index) {
    return SizedBox(
      width: index != 4 ? 180 : null,
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
        Text(nameShop[index]),
        const SizedBox(width: 10),
      ]),
    );
  }

  List<String> listStringNumber({required int start, required int end}) {
    List<String> data = [];

    for (var i = start; i <= end; i++) {
      data.add(i.toString());
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
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: text(text: 'เลือกร้านค้าปฏิบัติงาน', fontSize: 20, fontBold: true).paddingAll(10)),
              Wrap(children: nameShop.map<Widget>((e) => checkBoxShop(nameShop.indexOf(e))).toList()),
              Divider(thickness: 5, color: Colors.grey[200]),
              Center(child: text(text: 'ข้อมูลพนักงาน', fontSize: 20, fontBold: true).paddingAll(10)),
              text(text: 'รหัสพนักงานขาย', fontBold: true),
              formField(controller: _saleID, hintText: 'กรุณากรอกรหัสพนักงานขาย').paddingSymmetric(vertical: 10),
              text(text: 'ชื่อ', fontBold: true),
              formField(controller: _firstName, hintText: 'กรุณากรอก').paddingSymmetric(vertical: 10),
              text(text: 'นามสกุล', fontBold: true),
              formField(controller: _lastName, hintText: 'กรุณากรอก').paddingSymmetric(vertical: 10),
              text(text: 'วันเดือนปีเกิด', fontBold: true),
              Row(children: [
                dropdown(
                  flex: 2,
                  hint: 'วัน',
                  items: itemsDays,
                  selectedValue: selectedDay,
                  onChanged: (day) {
                    setState(() {
                      selectedDay = day as String;
                    });
                  },
                ),
                const SizedBox(width: 10),
                dropdown(
                  flex: 3,
                  hint: 'เดือน',
                  items: itemsMonths,
                  selectedValue: selectedMonth,
                  onChanged: (month) {
                    setState(() {
                      selectedMonth = month as String;
                    });
                  },
                ),
                const SizedBox(width: 10),
                dropdown(
                  flex: 3,
                  hint: 'ปี',
                  items: itemsYears,
                  selectedValue: selectedYear,
                  onChanged: (year) {
                    setState(() {
                      selectedYear = year as String;
                    });
                  },
                ),
              ]).paddingSymmetric(vertical: 10),
              text(text: 'เบอร์มือถือ', fontBold: true),
              formField(controller: _phoneNumber, hintText: 'กรุณากรอก').paddingSymmetric(vertical: 10),
              text(text: 'อีเมล', fontBold: true),
              formField(controller: _email, hintText: 'กรุณากรอก').paddingSymmetric(vertical: 10),
              text(text: 'ตำแหน่งงาน', fontBold: true),
              // dropdown(items: items)
              text(text: 'รหัสสาขา', fontBold: true),
              text(text: 'รหัสพนักงานขาย', fontBold: true),
              const SizedBox(height: 20),
              button(
                text: 'สร้างบัญชี',
                icon: Icons.add,
                onPressed: () => Get.to(const ConfirmOTP(), transition: Transition.rightToLeft),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
