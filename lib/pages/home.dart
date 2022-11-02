import 'package:flutter/material.dart';
import 'package:tms/state_management.dart';
import 'package:tms/widgets/box_news.dart';
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
        title: const Center(child: Text('ช่วยขาย true')),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      onDrawerChanged: (isOpened) {
        Store.drawer.value = isOpened;
      },
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 240,
              child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.brown.shade800,
                        maxRadius: 35,
                        child: text(text: 'AH'),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                          onTap: () {}, child: text(text: 'แก้ไขรูป', color: Colors.white, fontSize: 14, decoration: TextDecoration.underline)),
                      const SizedBox(height: 15),
                      text(text: 'ศนันธฉัตร  ธนพัฒน์พิศาล', color: Colors.white, fontSize: 20),
                      const SizedBox(height: 5),
                      text(text: '7-11 สาขาเจริญนคร 27', color: Colors.white),
                    ],
                  )),
            ),
            const ListTile(
              minLeadingWidth: 20,
              leading: Icon(Icons.account_circle),
              title: Text('ข้อมูลของคุณ'),
            ),
            const ListTile(
              minLeadingWidth: 20,
              leading: Icon(Icons.sync_lock),
              title: Text('เปลี่ยนรหัสผ่าน'),
            ),
            const ListTile(
              minLeadingWidth: 20,
              leading: Icon(Icons.settings),
              title: Text('ตั้งค่า'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    CircleAvatar(backgroundColor: Colors.brown.shade800, child: text(text: 'AH')),
                    const SizedBox(width: 5),
                    Expanded(child: text(text: 'คุณทดสอบ ชอบทดลอง')),
                    FittedBox(child: text(text: '7-11 สาขาเจริญนคร 27'))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    text(text: 'ยอดขายของคุณ'),
                    const SizedBox(height: 5),
                    text(text: 'ข้อมูลถึงวันที่ 19 ตุลาคม 2565'),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.red)),
                      child: Row(
                        children: [
                          FittedBox(child: Center(child: text(text: 'true', fontSize: 90, color: Colors.red))),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                text(text: 'ยอดขายรวมทุกสินค้า', fontSize: 20),
                                text(text: '17 รายการ', fontSize: 30),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    text(text: 'ข้อมูลการขาย'),
                    const SizedBox(height: 15),
                    listSales(phone: false, title: 'ซิม 7-11', content: '5 ซิม'),
                    listSales(phone: false, title: 'ซิมเติมเงิน', content: '2 ซิม'),
                    listSales(phone: false, title: 'ซิมรายเดือน', content: '5 ซิม'),
                    listSales(phone: true, title: 'ยอดมือถือ', content: '2 เครื่อง'),
                    const SizedBox(height: 15),
                    GestureDetector(onTap: () {}, child: text(text: 'ดูยอดขายทั้งหมด', color: Colors.red, decoration: TextDecoration.underline)),
                    const SizedBox(height: 15),
                    Row(
                      children: [const Icon(Icons.campaign, size: 30), text(text: 'ข่าวสารและแคมเปญเด่น')],
                    ),
                  ],
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
