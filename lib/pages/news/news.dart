import 'dart:async';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/apis/request/first_login.request.dart';
import 'package:tms/models/search_news.model.dart';
import 'package:tms/pages/detail.dart';
import 'package:tms/pages/news/news_more.dart';
import 'package:tms/pages/no_data.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/ga_log.dart';
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
  bool showSearch = false;

  List<Widget> groupNew = [];
  List searchNews = [];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    GALog.content('news-view');

    for (var news in Store.newsModel!.value.data!) {
      news!.lists!.removeWhere((news) => !news!.startDate!.isBefore(DateTime.now()) && news.endDate!.isAfter(DateTime.now()));

      if (news.lists!.isNotEmpty) {
        groupNew.add(SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Row(children: [
                  SvgPicture.asset('assets/images/${news.icon}.svg'),
                  text(news.nameTh!, fontBold: true, fontSize: 24, overflow: TextOverflow.ellipsis).paddingOnly(left: 10),
                ]).paddingSymmetric(vertical: 10, horizontal: 20),
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: news.lists!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return boxNews(
                      image: news.lists![index]!.thumbnailUrl!,
                      content: news.lists![index]!.headline!,
                      onTap: () => Get.to(() => DetailPage(news.lists![index])),
                    );
                  },
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () => (news.lists!.isNotEmpty) ? navigatorTo(() => NewsMore(news)) : null,
                  child: text('+ ?????????????????????????????????', color: (news.lists!.isNotEmpty) ? ThemeColor.primaryColor : Colors.grey),
                ),
              ).paddingOnly(bottom: 10),
              Divider(color: Colors.white.withOpacity(0.7), thickness: 20),
            ],
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: SvgPicture.asset('assets/images/head_appbar.svg', width: 100),
          bottom: (Store.newsModel != null)
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(70),
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFF414F5C),
                    child: Form(
                      child: formField(
                        hintText: '???????????????????????????????????????????????????????????????',
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
                                      showSearch = true;
                                      searchNews.clear();

                                      final SearchNewsModel searchNewsModel = SearchNewsModel.fromJson(news.response);

                                      for (var news in searchNewsModel.data!) {
                                        news!.lists!.removeWhere(
                                          (news) => !news!.startDate!.isBefore(DateTime.now()) && news.endDate!.isAfter(DateTime.now()),
                                        );

                                        searchNews.addAll(news.lists!);
                                      }
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
                await firstLoginRequest();
                setState(() {});
              })
            : (!showSearch)
                ? SingleChildScrollView(
                    child: Column(
                        children: (groupNew.isNotEmpty)
                            ? groupNew
                            : [
                                Center(
                                    child: Column(
                                  children: [
                                    SvgPicture.asset('assets/images/notfound.svg'),
                                    text('?????????????????????????????????????????????????????????????????????????????????', fontSize: 22, color: Colors.grey),
                                  ],
                                )).paddingOnly(top: 72)
                              ]),
                  )
                : (searchNews.isNotEmpty)
                    ? Column(children: [
                        Row(children: [
                          text('????????????????????? "'),
                          text(search.text, color: ThemeColor.primaryColor),
                          text('" ??????'),
                          text(' ${searchNews.length} ', color: ThemeColor.primaryColor),
                          text('??????????????????'),
                        ]),
                        const SizedBox(height: 10),
                        Expanded(
                          child: GridView.builder(
                            itemCount: searchNews.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 320),
                            itemBuilder: (context, index) {
                              return boxNews(
                                image: searchNews[index].thumbnailUrl,
                                content: searchNews[index].headline!,
                                onTap: () => Get.to(() => DetailPage(searchNews[index])),
                              );
                            },
                          ),
                        ),
                      ]).paddingOnly(left: 20, top: 10, right: 10, bottom: 20)
                    : Center(
                        child: Column(children: [
                        SvgPicture.asset('assets/images/notfound.svg'),
                        text('???????????????????????????????????????????????????????????????????????????', fontSize: 22, color: Colors.grey),
                      ])).paddingOnly(top: 72),
      ),
    );
  }
}
