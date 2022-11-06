import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/pages/sales/sales_summary.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/box_head_user.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ยอดขาย'),
        centerTitle: true,
        elevation: 0,
      ),
      onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
      drawer: Drawer(
        child: Column(children: <Widget>[
          SizedBox(
            height: 240,
            width: double.infinity,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: ThemeColor.primaryColor),
              child: Column(children: [
                CircleAvatar(
                  backgroundColor: Colors.brown.shade800,
                  maxRadius: 35,
                  child: text(text: 'AH'),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {},
                  child: text(text: 'แก้ไขรูป', color: Colors.white, fontSize: 16, decoration: TextDecoration.underline),
                ),
                const SizedBox(height: 15),
                text(text: 'ศนันธฉัตร  ธนพัฒน์พิศาล', color: Colors.white),
                text(text: '7-11 สาขาเจริญนคร 27', color: Colors.white, fontSize: 16),
              ]),
            ),
          ),
          ListTile(
            minLeadingWidth: 20,
            leading: SvgPicture.asset('assets/icons/profile.svg'),
            title: text(text: 'ข้อมูลของคุณ'),
          ),
          ListTile(
            minLeadingWidth: 20,
            leading: SvgPicture.asset('assets/icons/ChangePass.svg'),
            title: text(text: 'เปลี่ยนรหัสผ่าน'),
          ),
          const Spacer(),
          button(
            icon: Icons.exit_to_app,
            text: 'ออกจากระบบ',
            outline: true,
            colorOutline: ThemeColor.primaryColor,
            onPressed: () => navigatorOffAll(() => const LoginPage()),
          ).paddingSymmetric(horizontal: 40),
          text(text: 'v ${Store.version.value}', color: Colors.grey).paddingSymmetric(vertical: 10)
        ]),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF414F5C),
            child: Column(
              children: [
                text(text: 'สรุปยอดขายของคุณ', color: Colors.white),
                const SizedBox(height: 5),
                text(
                  text: DateFormat('ข้อมูลถึงวันที่ dd MMMM ${DateTime.now().year + 543}', 'th').format(DateTime.now().toLocal()),
                  color: Colors.white,
                ),
                const SizedBox(height: 15),
                boxHeadUser(name: 'ศนันธฉัตร ธนพัฒน์พิศาล', quantity: '17')
              ],
            ).paddingSymmetric(vertical: 15),
          ),
          const Expanded(child: SalesSummary()),
        ],
      ),
    );
  }
}
