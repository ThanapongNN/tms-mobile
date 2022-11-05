import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/text.dart';
import 'package:expandable/expandable.dart';

Widget listSales({
  required bool phone,
  required String title,
  required String content,
}) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey)),
    child: ExpandablePanel(
      theme: const ExpandableThemeData(
        headerAlignment: ExpandablePanelHeaderAlignment.center,
        useInkWell: false,
      ),
      header: ListTile(
        leading: SvgPicture.asset((phone) ? 'assets/images/phone with sim.svg' : 'assets/images/Sim.svg'),
        title: text(text: title, fontSize: 24),
        trailing: text(text: content, fontSize: 24),
      ),
      expanded: Column(
        children: [
          Container(
            color: ThemeColor.primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: ListTile(
                leading: text(text: 'เครื่องและรุ่น', color: Colors.white),
                trailing: text(text: 'ยอดขาย', color: Colors.white),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: 2,
            itemBuilder: (context, index) {
              return listSalesDetail(title: 'ซิมฟันธง', quantity: '2', unit: 'ซิม');
            },
          ),
        ],
      ),
      collapsed: const SizedBox(),
    ),
  ).paddingSymmetric(horizontal: 15, vertical: 10);
}

Widget listSalesDetail({required String title, required String quantity, required String unit}) {
  return Container(
    margin: const EdgeInsets.only(left: 10, right: 20),
    child: ListTile(
      leading: text(text: title),
      trailing: text(text: '$quantity $unit'),
    ),
  );
}
