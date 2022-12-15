import 'dart:async';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tms/models/search_news.model.dart';
import 'package:tms/pages/news/news_detail.dart';
import 'package:tms/pages/news/news_more.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/box_news.dart';
import 'package:tms/widgets/drawer.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/navigator.dart';
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

  final SearchNewsModel _searchNewsModel = SearchNewsModel.fromJson({
    "code": "200",
    "description": "SUCCESS",
    "transactionId": "transactionId",
    "data": [
      {
        "name_th": "รับซิมทรูเซเว่นฟรี",
        "name_en": "get_sim_7-11_free",
        "source_type": "VDO",
        "thumbnail_url": "https://cf.shopee.co.th/file/0ae43670de1b7344fcf559566d8e6cfa",
        "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
        "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
        "source_url": "https://drive.google.com/file/d/1A088jRcGJQjuP6zmZ5ogsOEFWZAzM3ib/view",
        "start_date": "2022-02-24T07:00:00+07:00",
        "end_date": "2022-12-31T07:00:00+07:00"
      },
      {
        "name_th": "เปลี่ยนเติมเงินเป็นรายเดือน",
        "name_en": "change prepaid sim to monthly sim",
        "source_type": "PDF",
        "thumbnail_url": "https://admin.adaddictth.com/storage/img/thumbnail/1638460620_thumpnail.jpg",
        "headline": "รับซิมทรูเซเว่นฟรี วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65",
        "sub_headline": "รับซิมทรูเซเว่นฟรี ที่ทรูช็อป หรือ 7-11 ได้แล้วตั้งแต่วันที่ 24 ก.พ. 65 - 31 ธ.ค. 65 เพียงพกบัตรประชาชนเพื่อรับฟรี",
        "source_url": "https://drive.google.com/file/d/1Ph02aoThudstesV2DlNerNKVqnV14xty/view",
        "start_date": "2022-02-24T07:00:00+07:00",
        "end_date": "2022-12-31T07:00:00+07:00"
      }
    ]
  });

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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              width: double.infinity,
              color: const Color(0xFF414F5C),
              child: Form(
                child: formField(
                  hintText: 'ค้นหาข่าวสารและแคมเปญ',
                  prefixIcon: const Icon(BootstrapIcons.search),
                  showTextLable: false,
                  controller: search,
                  radius: true,
                  onChanged: (v) async {
                    _timer?.cancel();
                    _timer = Timer(
                      const Duration(seconds: 1),
                      () async {
                        _timer?.cancel();
                        setState(() {
                          checkSearch = v.isEmpty;
                        });
                      },
                    );
                  },
                ).paddingOnly(left: 50, right: 50, top: 10),
              ),
            ),
          ),
        ),
        onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
        drawer: drawer(),
        body: (checkSearch)
            ? SingleChildScrollView(
                child: Column(
                  children: Store.newsModel!.value.data.map((e) {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            SvgPicture.asset('assets/images/${e.icon}.svg'),
                            text(e.nameTh, fontBold: true, fontSize: 24).paddingOnly(left: 10),
                          ]).paddingSymmetric(vertical: 10, horizontal: 20),
                          SizedBox(
                            height: 300,
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              scrollDirection: Axis.horizontal,
                              itemCount: e.lists.length,
                              itemBuilder: (BuildContext context, int index) {
                                return boxNews(
                                  image: e.lists[index].thumbnailUrl,
                                  content: e.lists[index].subHeadline,
                                  onTap: () => Get.to(() => NewsDetail(e.lists[index])),
                                );
                              },
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () => navigatorTo(() => NewsMore(e)),
                              child: text('+ ดูเพิ่มเติม', color: ThemeColor.primaryColor),
                            ),
                          ).paddingOnly(bottom: 10),
                          Divider(color: Colors.white.withOpacity(0.7), thickness: 20),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              )
            : (information)
                ? Column(children: [
                    Row(children: [
                      text('คำค้นหา "'),
                      text(search.text, color: ThemeColor.primaryColor),
                      text('" พบ'),
                      text(' ${_searchNewsModel.data.length} ', color: ThemeColor.primaryColor),
                      text('บทความ'),
                    ]),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        itemCount: _searchNewsModel.data.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 320),
                        itemBuilder: (context, index) {
                          return boxNews(
                            image: _searchNewsModel.data[index].thumbnailUrl,
                            content: _searchNewsModel.data[index].subHeadline,
                            onTap: () => Get.to(() => NewsDetail(_searchNewsModel.data[index])),
                          );
                        },
                      ),
                    ),
                  ]).paddingOnly(left: 20, top: 10, right: 10, bottom: 20)
                : Center(
                    child: Column(children: [
                    SvgPicture.asset('assets/icons/notfound.svg'),
                    text('ไม่พบข้อมูลที่ท่านต้องการ', fontSize: 22, color: Colors.grey),
                  ])).paddingOnly(top: 72),
      ),
    );
  }
}
