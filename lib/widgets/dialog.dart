import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/text.dart';

dialog({
  String title = 'คำเตือน',
  String content = '',
  String textCancle = 'Close',
  String textConfirm = 'Confirm',
  void Function()? onPressedCancle,
  void Function()? onPressedConfirm,
}) {
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
          onPressed: onPressedCancle ?? () => Get.back(),
          child: text(textCancle, color: Colors.white),
        ),
        const SizedBox(width: 10),
        MaterialButton(
          color: ThemeColor.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onPressed: onPressedConfirm ?? () => Get.back(),
          child: text(textConfirm, color: Colors.white),
        )
      ])
    ],
  );
}
