import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/box_news.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/list_sales.dart';

import 'package:tms/widgets/text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ช่วยขาย true'),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.notifications), onPressed: () {})],
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
            leading: const Icon(Icons.account_circle),
            title: text(text: 'ข้อมูลของคุณ'),
          ),
          ListTile(
            minLeadingWidth: 20,
            leading: const Icon(Icons.sync_lock),
            title: text(text: 'เปลี่ยนรหัสผ่าน'),
          ),
          ListTile(
            minLeadingWidth: 20,
            leading: const Icon(Icons.settings),
            title: text(text: 'ตั้งค่า'),
          ),
          const Spacer(),
          button(
            icon: Icons.exit_to_app,
            text: 'ออกจากระบบ',
            outline: true,
            colorOutline: ThemeColor.primaryColor,
            onPressed: () => Get.offAll(const LoginPage()),
          ).paddingSymmetric(horizontal: 40),
          text(text: 'v ${Store.version.value}', color: Colors.grey).paddingSymmetric(vertical: 10)
        ]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.grey[200],
              child: Row(children: [
                CircleAvatar(backgroundColor: Colors.brown.shade800, child: text(text: 'AH')),
                const SizedBox(width: 5),
                Expanded(child: text(text: 'คุณทดสอบ ชอบทดลอง')),
                FittedBox(child: text(text: '7-11 สาขาเจริญนคร 27'))
              ]),
            ),
            Column(children: [
              const SizedBox(height: 10),
              text(text: 'สรุปยอดขายของคุณ', fontSize: 24),
              const SizedBox(height: 5),
              text(text: DateFormat('ข้อมูลถึงวันที่ dd MMMM ${DateTime.now().year + 543}', 'th').format(DateTime.now().toLocal())),
              Container(
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: ThemeColor.primaryColor)),
                child: Row(children: [
                  FittedBox(child: Center(child: text(text: 'true', fontSize: 90, color: ThemeColor.primaryColor))),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        text(text: 'ยอดขายรวมทุกสินค้า'),
                        text(text: '17 รายการ', fontSize: 30),
                      ],
                    ),
                  )
                ]),
              ),
              text(text: 'ข้อมูลการขาย', fontSize: 24),
              listSales(phone: false, title: 'ซิม 7-11', content: '5 ซิม'),
              listSales(phone: false, title: 'ซิมเติมเงิน', content: '2 ซิม'),
              listSales(phone: false, title: 'ซิมรายเดือน', content: '5 ซิม'),
              listSales(phone: true, title: 'ยอดมือถือ', content: '2 เครื่อง'),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => Store.currentIndex.value = 1,
                child: text(text: 'ดูยอดขายทั้งหมด', color: ThemeColor.primaryColor, decoration: TextDecoration.underline),
              ),
              const SizedBox(height: 15),
              Row(children: [const Icon(Icons.campaign, size: 30), text(text: 'ข่าวสารและแคมเปญเด่น')]),
            ]).paddingSymmetric(horizontal: 10),
            const SizedBox(height: 10),
            Wrap(
              spacing: 15,
              runSpacing: 10,
              children: <Widget>[
                boxNews(),
                boxNews(),
                boxNews(),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
