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
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(offset: Offset(2, 2), color: Colors.black12, blurRadius: 2)],
      ),
      child: Column(children: [
        Container(
          height: 180,
          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        ),
        Expanded(child: text(content).paddingAll(5))
      ]),
    ).marginOnly(right: 10),
  );
}
