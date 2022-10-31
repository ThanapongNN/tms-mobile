import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/create_account/confirm_otp.dart';
import 'package:tms/widgets/tms_button.dart';
import 'package:tms/widgets/tms_text.dart';

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
  List<String> nameShop = ['7-11', 'Lotus HDE', 'Lotus Go Fresh', 'Lotus Talad', 'CP Frash Mart'];
  List<bool> selectShop = [false, false, false, false, false];

  checkBoxShop(int index) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สร้างบัญชีใหม่')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: tmsText(text: 'เลือกร้านค้าปฏิบัติงาน', fontSize: 20).paddingAll(10)),
          Wrap(children: nameShop.map<Widget>((e) => checkBoxShop(nameShop.indexOf(e))).toList()),
          Divider(thickness: 5, color: Colors.grey[200]),
          Center(child: tmsText(text: 'ข้อมูลพนักงาน', fontSize: 20).paddingAll(10)),
          tmsText(text: 'รหัสพนักงานขาย'),
          tmsText(text: 'ชื่อ'),
          tmsText(text: 'นามสกุล'),
          tmsText(text: 'วันเดือนปีเกิด'),
          tmsText(text: 'เบอร์์มือถือ'),
          tmsText(text: 'อีเมล'),
          tmsText(text: 'ตำแหน่งงาน'),
          tmsText(text: 'รหัสสาขา'),
          tmsText(text: 'รหัสพนักงานขาย'),
          const SizedBox(height: 20),
          tmsButton(
            text: 'สร้างบัญชี',
            icon: Icons.add,
            onPressed: () => Get.to(const ConfirmOTP(), transition: Transition.rightToLeft),
          ),
        ]),
      ),
    );
  }
}
