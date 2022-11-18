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
            const CircleAvatar(
              backgroundColor: Colors.red,
              backgroundImage: AssetImage('assets/images/no_avatar.png'),
            ),
            const SizedBox(width: 10),
            text(name, fontSize: 20),
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
              text('ยอดขายรวม', fontSize: 20),
              text(' $quantity ', fontSize: 22, fontBold: true, color: ThemeColor.primaryColor),
              text('รายการ', fontSize: 20),
            ],
          ),
        ).paddingSymmetric(vertical: 5),
      ],
    ),
  );
}
