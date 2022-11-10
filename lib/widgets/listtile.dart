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
      leading: SvgPicture.asset(svgicon, height: 35).paddingOnly(top: (subtitle != null) ? 8 : 0),
      title: text(title, color: (changeMark) ? Colors.black : Colors.grey[600]).paddingOnly(bottom: (subtitle != null) ? 5 : 0),
      subtitle: (subtitle != null)
          ? subtitle
          : (content != null)
              ? text(content, fontSize: 18, color: (changeMark) ? Colors.grey[600] : Colors.black)
              : null,
      trailing: (trailing != null) ? trailing : null,
    ).paddingSymmetric(vertical: (content == null && subtitle == null) ? 10 : 0),
  ).paddingSymmetric(vertical: 10);
}
