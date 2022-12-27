import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tms/widgets/text.dart';

Widget boxHeadStatus({
  required String image,
  double? sizeImage,
  required String content,
  required String quantity,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xFFFFEEF1),
    ),
    width: 350,
    child: Row(
      children: [
        Expanded(
            flex: 2,
            child: Center(
                child: SvgPicture.asset(
              image,
              width: (sizeImage == null) ? 70 : sizeImage,
            ).paddingSymmetric())),
        Expanded(
          flex: 5,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(child: text(content, fontSize: 20, color: Colors.red)),
                FittedBox(child: text(quantity, fontSize: 20, fontBold: true)),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
