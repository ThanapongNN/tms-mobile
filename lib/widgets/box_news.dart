import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tms/widgets/text.dart';

Widget boxNews() {
  return SizedBox(
    height: 190,
    width: Get.width / 2 - 30,
    child: Column(
      children: [
        Container(
          color: Colors.amber,
          height: 120,
          child: Image.asset('assets/images/promotion.png'),
        ),
        const SizedBox(height: 5),
        text(text: "รับซิทรูเซว่นฟรี วันที่ 24 ก.พ 65 - 31 มี.ค. 65"),
      ],
    ),
  );
}
