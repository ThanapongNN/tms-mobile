import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
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
          return Row(children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(data.lists[index].thumbnailUrl),
                  fit: BoxFit.cover,
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
          ]).paddingOnly(bottom: 10);
        },
      ),
    );
  }
}
