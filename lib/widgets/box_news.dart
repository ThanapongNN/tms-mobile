import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms/widgets/text.dart';

Widget boxNews({
  required String image,
  required String content,
  required void Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 180,
      height: 230,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: Colors.amber,
            height: 180,
            child: Image.asset(image),
          ),
          Expanded(child: text(text: content).paddingAll(5))
        ],
      ),
    ).marginOnly(right: 10),
  );
}
