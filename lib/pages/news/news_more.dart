import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tms/models/news.model.dart';
import 'package:tms/pages/news/news_detail.dart';
import 'package:tms/widgets/box_news.dart';

class NewsMore extends StatelessWidget {
  final Datum data;
  const NewsMore(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data.nameTh)),
      body: GridView.builder(
        itemCount: data.lists.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 320),
        padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
        itemBuilder: (context, index) {
          return boxNews(
            image: data.lists[index].thumbnailUrl,
            content: data.lists[index].subHeadline,
            onTap: () => Get.to(() => NewsDetail(data.lists[index])),
          );
        },
      ),
    );
  }
}
