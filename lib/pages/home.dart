import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/pages/news/new_detail.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/box_head_status.dart';
import 'package:tms/widgets/box_news.dart';
import 'package:tms/widgets/box_sales.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/drawer.dart';
import 'package:tms/widgets/navigator.dart';

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Image.asset('assets/images/head_appbar.png', width: 100),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: ThemeColor.primaryColor,
            child: Row(children: [
              CircleAvatar(backgroundColor: Colors.brown.shade800, child: text(text: 'AH')),
              const SizedBox(width: 5),
              Expanded(child: text(text: 'คุณทดสอบ ชอบทดลอง', color: Colors.white)),
              FittedBox(child: text(text: '7-11 สาขาเจริญนคร 27', color: Colors.white))
            ]),
          ),
        ),
      ),
      onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
      drawer: drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(children: [
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
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 90,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                    ),
                    items: [
                      boxHeadStatus(image: 'assets/images/true.svg', content: 'ยอดขายรวมทุกสินค้า', quantity: '18'),
                      boxHeadStatus(image: 'assets/images/phone_sim.svg', content: 'ยอดขายเบอร์และมือถือ', quantity: '22'),
                      boxHeadStatus(image: 'assets/images/TV.svg', content: 'ยอดสมัครเน็ตบ้านและทีวี', quantity: '10'),
                      boxHeadStatus(image: 'assets/images/coin.svg', content: 'ยอดขายเติมเงินเติมเน็ต', quantity: '9'),
                    ],
                  ),
                ],
              ).paddingSymmetric(vertical: 15),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  boxSales(phone: false, title: 'ซิมเติมเงิน', content: '5 ซิม'),
                  boxSales(phone: false, title: 'ซิม 7-11', content: '5 ซิม'),
                  boxSales(phone: false, title: 'ซิมรายเดือน', content: '5 ซิม'),
                  boxSales(phone: true, title: 'ยอดมือถือ', content: '5 เครื่อง '),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () => Store.currentIndex.value = 1,
                    child: text(text: 'ดูยอดขายทั้งหมด', color: ThemeColor.primaryColor, decoration: TextDecoration.underline),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(text: 'ข่าวสารและแคมเปญเด่น', fontBold: true, fontSize: 24),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return boxNews(
                            image: 'assets/images/promotion.png',
                            content: 'ทรูให้เครื่องฟรี ที่ 7-Eleven เมื่อเปิด เบอร์ ใหม่รายเดือนหรือใช้ เบอร์เดิม WIKO Y82',
                            onTap: () => Get.to(() => const NewDetail()));
                      },
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20),
            ),
          ]),
        ),
      ),
    );
  }
}
