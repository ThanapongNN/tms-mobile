import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/pages/news/new_detail.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/box_news.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/head_appbar.png', width: 100),
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
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF414F5C),
            child: text(text: 'text', color: Colors.white),
          ),
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
    );
  }
}
