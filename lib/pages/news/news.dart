import 'dart:async';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/apis/request/first_login.request.dart';
import 'package:tms/models/search_news.model.dart';
import 'package:tms/pages/detail.dart';
// import 'package:tms/pages/news/detail_test.dart';
import 'package:tms/pages/news/news_more.dart';
import 'package:tms/pages/no_data.dart';
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

  bool showSearch = false;

  late SearchNewsModel _searchNewsModel;

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logScreenView(screenName: 'news-screen');
  }

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
          bottom: (Store.newsModel != null)
              ? PreferredSize(
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
                        onChanged: (v) {
                          _timer?.cancel();
                          _timer = Timer(
                            const Duration(seconds: 1),
                            () {
                              _timer?.cancel();

                              if (v.isNotEmpty) {
                                Call.raw(method: Method.get, url: '$host/news-campaign/v1/news-campaign/$v').then((news) {
                                  if (news.success) {
                                    setState(() {
                                      _searchNewsModel = SearchNewsModel.fromJson(news.response);
                                      showSearch = true;
                                    });
                                  }
                                });
                              } else {
                                setState(() {
                                  showSearch = false;
                                });
                              }
                            },
                          );
                        },
                      ).paddingOnly(left: 50, right: 50, top: 10),
                    ),
                  ),
                )
              : null,
        ),
        onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
        drawer: drawer(),
        body: (Store.newsModel == null)
            ? NoDataPage(onPressed: () async {
                await firstLoginRequest(Store.encryptedEmployeeId.value);
                setState(() {});
              })
            : (!showSearch)
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
                                      onTap: () => Get.to(() => DetailPage(e.lists[index])),
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
                : (_searchNewsModel.data.isNotEmpty)
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
                                onTap: () => Get.to(() => DetailPage(_searchNewsModel.data[index])),
                              );
                            },
                          ),
                        ),
                      ]).paddingOnly(left: 20, top: 10, right: 10, bottom: 20)
                    : Center(
                        child: Column(children: [
                        SvgPicture.asset('assets/images/notfound.svg'),
                        text('ไม่พบข้อมูลที่ท่านต้องการ', fontSize: 22, color: Colors.grey),
                      ])).paddingOnly(top: 72),
      ),
    );
  }
}
