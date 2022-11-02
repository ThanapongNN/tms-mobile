import 'package:flutter/material.dart';
import 'package:tms/widgets/text.dart';

Widget listSales({
  required bool phone,
  required String title,
  required String content,
}) {
  return ExpansionTile(
    title: Row(
      children: [
        Icon((phone) ? Icons.sim_card : Icons.mobile_screen_share, size: 40, color: Colors.amber),
        Expanded(child: text(text: title)),
        text(text: content, fontBold: true, fontSize: 18),
      ],
    ),
    children: <Widget>[
      ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: 2,
          itemBuilder: (context, index) {
            return listSalesDetail(title: 'ซิมฟันธง', quantity: '2', unit: 'ซิม');
          })
    ],
  );
}

Widget listSalesDetail({required String title, required String quantity, required String unit}) {
  return Container(
    color: Colors.grey[200],
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 40),
      title: text(text: title),
      trailing: text(text: '$quantity $unit'),
    ),
  );
}
