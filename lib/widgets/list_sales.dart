import 'package:flutter/material.dart';
import 'package:tms/widgets/text.dart';

Widget listSales({
  required bool phone,
  required String title,
  required String content,
}) {
  return GestureDetector(
    onTap: () {},
    child: Column(
      children: [
        Row(children: [
          Icon(
            (phone) ? Icons.sim_card : Icons.mobile_screen_share,
            size: 40,
            color: Colors.amber,
          ),
          Expanded(child: text(text: title)),
          text(text: content, fontBold: true, fontSize: 18),
          const Icon(Icons.expand_more)
        ]),
        const Divider(thickness: 2)
      ],
    ),
  );
}
