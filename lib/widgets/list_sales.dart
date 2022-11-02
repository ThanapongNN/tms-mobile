import 'package:flutter/material.dart';
import 'package:tms/widgets/text.dart';
import 'package:expandable/expandable.dart';

Widget listSales({
  required bool phone,
  required String title,
  required String content,
}) {
  return ExpandablePanel(
    theme: const ExpandableThemeData(
      headerAlignment: ExpandablePanelHeaderAlignment.center,
      useInkWell: false,
    ),
    header: ListTile(
      leading: Icon((phone) ? Icons.sim_card : Icons.mobile_screen_share, size: 30, color: Colors.amber),
      title: text(text: title, fontSize: 24),
      trailing: text(text: content, fontSize: 24),
    ),
    collapsed: const Divider(),
    expanded: ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 2,
      itemBuilder: (context, index) {
        return listSalesDetail(title: 'ซิมฟันธง', quantity: '2', unit: 'ซิม');
      },
    ),
  );
}

Widget listSalesDetail({required String title, required String quantity, required String unit}) {
  return Container(
    color: Colors.grey[200],
    margin: const EdgeInsets.only(left: 20, right: 10),
    child: ListTile(
      leading: text(text: title),
      trailing: text(text: '$quantity $unit'),
    ),
  );
}
