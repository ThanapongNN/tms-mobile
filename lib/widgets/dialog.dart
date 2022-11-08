import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/text.dart';

dialog({required String title, required String content, String textCancle = 'Close', String textConfirm = 'Confirm'}) {
  if (Get.isDialogOpen!) Get.back();
  Get.defaultDialog(
    title: title,
    titleStyle: const TextStyle(color: ThemeColor.primaryColor),
    middleText: content,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    titlePadding: const EdgeInsets.only(top: 20),
    actions: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        MaterialButton(
          color: ThemeColor.cancleColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onPressed: () {},
          child: text(text: textCancle, color: Colors.white),
        ),
        const SizedBox(width: 10),
        MaterialButton(
          color: ThemeColor.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onPressed: () {},
          child: text(text: textConfirm, color: Colors.white),
        )
      ])
    ],
  );
}
