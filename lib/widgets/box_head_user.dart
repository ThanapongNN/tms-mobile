import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/text.dart';

Widget boxHeadUser({
  // required String image,
  required String name,
  required String quantity,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xFFFFEEF1),
    ),
    width: 350,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.brown.shade800,
              maxRadius: 20,
              child: text(text: 'AH'),
            ),
            const SizedBox(width: 10),
            text(text: name, fontSize: 20),
          ],
        ).paddingSymmetric(vertical: 5),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text(text: 'ยอดขายรวม', fontSize: 20),
              text(text: ' $quantity ', fontSize: 22, fontBold: true, color: ThemeColor.primaryColor),
              text(text: 'รายการ', fontSize: 20),
            ],
          ),
        ).paddingSymmetric(vertical: 5),
      ],
    ),
  );
}
