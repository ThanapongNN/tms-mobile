import 'dart:async';

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

  Timer? _timer;

  bool checkSearch = true;
  bool information = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/head_appbar.svg', width: 100),
              const Text('  (mock)'),
            ],
          ),
          centerTitle: true,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              width: double.infinity,
              color: const Color(0xFF414F5C),
              child: Form(
                  child: formField(
                onChanged: (v) async {
                  _timer?.cancel();
                  _timer = Timer(
                    const Duration(seconds: 1),
                    () async {
                      _timer?.cancel();
                      if (v == '') {
                        setState(() {
                          checkSearch = true;
                        });
                      } else {
                        setState(() {
                          checkSearch = false;
                        });
                      }
                    },
                  );
                },
                showTextLable: false,
                controller: search,
                radius: true,
                prefixIcon: const Icon(BootstrapIcons.search),
                hintText: 'ค้นหาข่าวสารและแคมเปญ',
              ).paddingOnly(left: 50, right: 50, top: 10)),
            ),
          ),
        ),
        onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
        drawer: drawer(),
        body: (checkSearch)
            ? SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text('ข่าวสารและแคมเปญเด่น', fontBold: true, fontSize: 24).paddingSymmetric(vertical: 10, horizontal: 20),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        ).marginSymmetric(vertical: 10),
                        Divider(color: Colors.white.withOpacity(0.7), thickness: 20),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text('สินค้าทรูมูฟเอช', fontBold: true, fontSize: 24).paddingSymmetric(vertical: 10, horizontal: 20),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        ).marginSymmetric(vertical: 10),
                        Divider(color: Colors.white.withOpacity(0.7), thickness: 20),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text('สินค้าทรูออนไลน์และคอนเวอเจ้นท์', fontBold: true, fontSize: 24).paddingSymmetric(vertical: 10, horizontal: 20),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        ).marginSymmetric(vertical: 10),
                        Divider(color: Colors.white.withOpacity(0.7), thickness: 20),
                      ],
                    ),
                  ),
                ]),
              )
            : (information)
                ? Column(
                    children: [
                      Row(
                        children: [
                          text('คำค้นหา “'),
                          text(search.text, color: ThemeColor.primaryColor),
                          text('” พบ'),
                          text(' 20 ', color: ThemeColor.primaryColor),
                          text('บทความ'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 280, mainAxisSpacing: 20),
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return boxNews(
                                  image: 'assets/images/promotion.png',
                                  content: 'ทรูให้เครื่องฟรี ที่ 7-Eleven เมื่อเปิด เบอร์ ใหม่รายเดือนหรือใช้ เบอร์เดิม WIKO Y82',
                                  onTap: () => Get.to(() => const NewDetail()));
                            }),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20, vertical: 10)
                : Center(
                    child: Column(children: [
                    SvgPicture.asset('assets/icons/notfound.svg'),
                    text('ไม่พบข้อมูลที่ท่านต้องการ', fontSize: 22, color: Colors.grey),
                  ])).paddingOnly(top: 72),
      ),
    );
  }
}
