import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tms/widgets/text.dart';

Widget listTile({
  required String svgicon,
  required String title,
  String? content,
  Widget? subtitle,
  Widget? trailing,
  bool changeMark = false,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade400)),
    child: ListTile(
      leading: SvgPicture.asset(svgicon, height: 35),
      title: text(title, color: (changeMark) ? Colors.black : Colors.grey[600]),
      subtitle: (content != null)
          ? (subtitle != null)
              ? subtitle
              : text(content, fontSize: 18, color: (changeMark) ? Colors.grey[600] : Colors.black)
          : null,
      trailing: (trailing != null) ? trailing : null,
    ).paddingSymmetric(vertical: (content != null) ? 0 : 10),
  ).paddingSymmetric(vertical: 10);
}
