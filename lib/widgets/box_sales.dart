import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/text.dart';

Widget boxSales({
  required bool phone,
  required String title,
  required String quantity,
  required String unit,
}) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey)),
    child: ListTile(
      leading: SvgPicture.asset((phone) ? 'assets/images/phone_with_sim.svg' : 'assets/images/sim.svg'),
      title: text(title, fontSize: 24),
      trailing: Wrap(children: [
        text(quantity, fontSize: 24, color: ThemeColor.primaryColor),
        const SizedBox(width: 5),
        text(unit, fontSize: 24),
      ]),
    ).paddingSymmetric(horizontal: 10),
  ).paddingSymmetric(horizontal: 15, vertical: 10);
}
