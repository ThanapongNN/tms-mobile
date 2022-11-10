import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tms/pages/news/new_detail.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/box_news.dart';
import 'package:tms/widgets/drawer.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/text.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: SvgPicture.asset('assets/images/head_appbar.svg', width: 100),
          centerTitle: true,
          elevation: 0,
        ),
        onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
        drawer: drawer(),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                width: double.infinity,
                color: const Color(0xFF414F5C),
                child: Form(
                    child: formField(
                  showTextLable: false,
                  controller: search,
                  radius: true,
                  prefixIcon: const Icon(BootstrapIcons.search),
                  hintText: 'ค้นหาข่าวสารและแคมเปญ',
                ).paddingSymmetric(horizontal: 20, vertical: 10))),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text('ข่าวสารและแคมเปญเด่น', fontBold: true, fontSize: 24).paddingSymmetric(vertical: 10),
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
                  SizedBox(
                    child: Center(
                        child: GestureDetector(
                      onTap: () {},
                      child: text('+ ดูเพิ่มเติม', color: ThemeColor.primaryColor),
                    )),
                  ).marginSymmetric(vertical: 10)
                ],
              ).paddingSymmetric(horizontal: 20),
            ),
            Divider(color: Colors.white.withOpacity(0.7), thickness: 20),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text('สินค้าทรูมูฟเอช', fontBold: true, fontSize: 24).paddingSymmetric(vertical: 10),
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
                  SizedBox(
                    child: Center(
                        child: GestureDetector(
                      onTap: () {},
                      child: text('+ ดูเพิ่มเติม', color: ThemeColor.primaryColor),
                    )),
                  ).marginSymmetric(vertical: 10)
                ],
              ).paddingSymmetric(horizontal: 20),
            ),
            Divider(color: Colors.white.withOpacity(0.7), thickness: 20),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text('สินค้าทรูออนไลน์และคอนเวอเจ้นท์', fontBold: true, fontSize: 24).paddingSymmetric(vertical: 10),
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
                  SizedBox(
                    child: Center(
                        child: GestureDetector(
                      onTap: () {},
                      child: text('+ ดูเพิ่มเติม', color: ThemeColor.primaryColor),
                    )),
                  ).marginSymmetric(vertical: 10)
                ],
              ).paddingSymmetric(horizontal: 20),
            ),
            Divider(color: Colors.white.withOpacity(0.7), thickness: 20),
          ]),
        ),
      ),
    );
  }
}
