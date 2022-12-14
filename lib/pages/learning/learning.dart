import 'dart:async';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/apis/request/first_login.request.dart';
import 'package:tms/models/search_learning.model.dart';
import 'package:tms/pages/detail.dart';
import 'package:tms/pages/learning/learning_more.dart';
import 'package:tms/pages/no_data.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/ga_log.dart';
import 'package:tms/widgets/box_learning.dart';
import 'package:tms/widgets/drawer.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({super.key});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  final search = TextEditingController();
  bool showSearch = false;

  List<Widget> groupLearning = [];
  List searchLearning = [];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    GALog.content('learning-view');

    for (var learning in Store.learningModel!.value.data!) {
      learning!.lists!.removeWhere((news) => !news!.startDate!.isBefore(DateTime.now()) && news.endDate!.isAfter(DateTime.now()));

      if (learning.lists!.isNotEmpty) {
        groupLearning.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              SvgPicture.asset('assets/images/${learning.icon}.svg'),
              text(learning.nameTh!, fontBold: true, fontSize: 24).paddingOnly(left: 10),
            ]),
            const SizedBox(height: 10),
            SizedBox(
              height: (learning.lists!.length > 2) ? 300 : 150,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: learning.lists!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 150),
                itemBuilder: (context, index) {
                  return boxLearning(
                    image: learning.lists![index]!.thumbnailUrl!,
                    content: learning.lists![index]!.headline!,
                    onTap: () => Get.to(() => DetailPage(learning.lists![index])),
                  );
                },
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () => (learning.lists!.isNotEmpty) ? navigatorTo(() => LearningMore(learning)) : null,
                child: text('+ ?????????????????????????????????', color: (learning.lists!.isNotEmpty) ? ThemeColor.primaryColor : Colors.grey),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 10));
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
          bottom: (Store.learningModel != null)
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(70),
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFF414F5C),
                    child: Form(
                      child: formField(
                        hintText: '??????????????????????????????????????????????????????',
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
                                Call.raw(method: Method.get, url: '$host/learning-course/v1/learning-course/$v').then((learning) {
                                  if (learning.success) {
                                    setState(() {
                                      showSearch = true;
                                      searchLearning.clear();

                                      final SearchLearningModel searchLearningModel = SearchLearningModel.fromJson(learning.response);

                                      for (var learning in searchLearningModel.data!) {
                                        learning!.lists!.removeWhere(
                                          (news) => !news!.startDate!.isBefore(DateTime.now()) && news.endDate!.isAfter(DateTime.now()),
                                        );

                                        searchLearning.addAll(learning.lists!);
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
        body: (Store.learningModel == null)
            ? NoDataPage(onPressed: () async {
                await firstLoginRequest();
                setState(() {});
              })
            : (!showSearch)
                ? SingleChildScrollView(
                    child: Column(
                      children: (groupLearning.isNotEmpty)
                          ? groupLearning
                          : [
                              Center(
                                child: Column(children: [
                                  SvgPicture.asset('assets/images/notfound.svg'),
                                  text('????????????????????????????????????????????????????????????????????????', fontSize: 22, color: Colors.grey),
                                ]),
                              ).paddingOnly(top: 72)
                            ],
                    ),
                  )
                : (searchLearning.isNotEmpty)
                    ? Column(children: [
                        Row(children: [
                          text('????????????????????? "'),
                          text(search.text, color: ThemeColor.primaryColor),
                          text('" ??????'),
                          text(' ${searchLearning.length} ', color: ThemeColor.primaryColor),
                          text('??????????????????'),
                        ]),
                        const SizedBox(height: 10),
                        Expanded(
                          child: GridView.builder(
                            itemCount: searchLearning.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 150),
                            itemBuilder: (context, index) {
                              return boxLearning(
                                image: searchLearning[index].thumbnailUrl,
                                content: searchLearning[index].headline,
                                onTap: () => Get.to(() => DetailPage(searchLearning[index])),
                              );
                            },
                          ),
                        ),
                      ]).paddingOnly(left: 20, top: 10, right: 10, bottom: 20)
                    : Center(
                        child: Column(children: [
                          SvgPicture.asset('assets/images/notfound.svg'),
                          text('???????????????????????????????????????????????????????????????????????????', fontSize: 22, color: Colors.grey),
                        ]),
                      ).paddingOnly(top: 72),
      ),
    );
  }
}
