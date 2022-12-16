import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/learning/learning_detail.dart';
import 'package:tms/widgets/text.dart';

class LearningMore extends StatelessWidget {
  final dynamic data;
  const LearningMore(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(title: Text(data.nameTh)),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: data.lists.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Get.to(() => LearningDetail(data.lists[index])),
            child: Row(children: [
              SizedBox(
                height: 90,
                width: 90,
                child: CachedNetworkImage(
                  imageUrl: data.lists[index].thumbnailUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    height: 90,
                    width: 90,
                    child: const Icon(Icons.image, size: 30, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 90,
                  color: Colors.white,
                  child: text(data.lists[index].subHeadline),
                ),
              ),
            ]).paddingOnly(bottom: 10),
          );
        },
      ),
    );
  }
}
