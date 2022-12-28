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
  bool compensation = false,
  List? detail,
  String? sum,
}) {
  int checklist = detail?.length ?? 0;
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
          leading: SvgPicture.asset('assets/images/$icon.svg'),
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
              (!compensation)
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: checklist,
                      itemBuilder: (context, index) {
                        return listSalesDetail(
                          title: detail?[index]['name'],
                          quantity: '${detail?[index]['ea']}',
                          unit: detail?[index]['unit'],
                          index: index,
                          maxIndex: checklist,
                        );
                      })
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: checklist + 1,
                      itemBuilder: (context, index) {
                        if (index < checklist) {
                          return listSalesDetail(
                            title: detail?[index].name,
                            quantity: '${detail?[index].ea}',
                            unit: detail?[index].unit,
                            index: index,
                            maxIndex: checklist,
                            total: '${detail?[index].total}',
                          );
                        } else {
                          return listSalesDetail(title: 'รวม', total: '$sum', index: index, maxIndex: checklist);
                        }
                      },
                    ),
          ],
        ),
        collapsed: const SizedBox(),
      ),
    ),
  ).paddingSymmetric(horizontal: 15, vertical: 10);
}

Widget listSalesDetail({
  required String title,
  String? quantity,
  String? total,
  String? unit,
  required int index,
  required int maxIndex,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 25, right: 37),
    decoration: BoxDecoration(
      color: (index % 2 == 0) ? Colors.grey[100] : Colors.white,
      borderRadius: (total == null)
          ? (maxIndex - 1 == index)
              ? const BorderRadius.only(bottomLeft: Radius.circular(9), bottomRight: Radius.circular(9))
              : null
          : (maxIndex == index)
              ? const BorderRadius.only(bottomLeft: Radius.circular(9), bottomRight: Radius.circular(9))
              : null,
    ),
    child: Row(
      children: [
        Expanded(flex: 6, child: text(title)),
        if (quantity != null && unit != null)
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  text(quantity, color: ThemeColor.primaryColor),
                  const SizedBox(width: 5),
                  text(unit),
                ],
              )),
        if (total != null)
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                text(total, color: ThemeColor.primaryColor),
                const SizedBox(width: 5),
                text('บาท'),
              ],
            ),
          ),
      ],
    ).paddingSymmetric(vertical: 10),
  );
}
