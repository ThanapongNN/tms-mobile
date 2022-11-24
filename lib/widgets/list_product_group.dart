import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/text.dart';
import 'package:expandable/expandable.dart';

Widget listProductGroup({
  required String icon,
  required String title,
  required String quantity,
  required String unit,
  required bool seeDetail,
  List? detail,
}) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey)),
    child: ExpandableTheme(
      data: ExpandableThemeData(
        iconColor: (seeDetail) ? ThemeColor.primaryColor : Colors.grey,
        iconRotationAngle: (seeDetail) ? null : 0,
      ),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          useInkWell: false,
        ),
        header: ListTile(
          leading: SvgPicture.asset(icon),
          title: text(title, fontSize: 24, overflow: TextOverflow.ellipsis),
          trailing: Wrap(children: [
            text(quantity, fontSize: 24, color: ThemeColor.primaryColor),
            const SizedBox(width: 5),
            text(unit, fontSize: 24),
          ]),
        ),
        expanded: Column(
          children: [
            if (seeDetail)
              Container(
                color: ThemeColor.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: ListTile(
                    leading: text('เครื่องและรุ่น', color: Colors.white),
                    trailing: text('ยอดขาย', color: Colors.white),
                  ),
                ),
              ),
            if (seeDetail)
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: detail?.length,
                itemBuilder: (context, index) {
                  return listSalesDetail(title: detail?[index].name, quantity: detail?[index].ea, unit: detail?[index].unit);
                },
              ),
          ],
        ),
        collapsed: const SizedBox(),
      ),
    ),
  ).paddingSymmetric(horizontal: 15, vertical: 10);
}

Widget listSalesDetail({required String title, required String quantity, required String unit}) {
  return Container(
    margin: const EdgeInsets.only(left: 10, right: 20),
    child: ListTile(
      leading: text(title),
      trailing: Wrap(
        children: [
          text(quantity, color: ThemeColor.primaryColor),
          const SizedBox(width: 5),
          text(unit),
        ],
      ),
    ),
  );
}
