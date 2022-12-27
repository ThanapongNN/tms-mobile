import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms/models/compensation_data.model.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/list_product_group.dart';
import 'package:tms/widgets/text.dart';

class Compensation extends StatefulWidget {
  const Compensation({super.key});

  @override
  State<Compensation> createState() => _CompensationState();
}

class _CompensationState extends State<Compensation> {
  Map mockdata = {
    "data": [
      {
        "code": "p001",
        "product": "ยอดมือถือ",
        "salesTotal": 3,
        "unit": "เครื่อง",
        "iconName": "sim",
        "salesOrder": [
          {"name": "VIVO Y15S", "ea": 1, "unit": "เครื่อง", "total": "100"},
          {"name": "ATV SKY", "ea": 1, "unit": "เครื่อง", "total": "20"},
          {"name": "HUAWEI NOVA Y70", "ea": 1, "unit": "เครื่อง", "total": "20"},
          {"name": "HUAWEI NOVA Y70", "ea": 1, "unit": "เครื่อง", "total": "20"},
        ],
        "sum": 360,
      },
      {
        "code": "p002",
        "product": "ซิมเติมเงิน",
        "salesTotal": 1,
        "unit": "ซิม",
        "iconName": "sim",
        "salesOrder": [
          {"name": "ซิมเบอร์ใหม่แบบเติมเงิน ฟันธง", "ea": 1, "unit": "เครื่อง", "total": "50"},
        ],
        "sum": 360,
      }
    ]
  };

  CompensationData compensationData = CompensationData.fromJson(Store.compersationData);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Center(child: text('*ผลตอบแทนทั้งหมดเป็นเพียงแค่ยอดประมาณการ', color: ThemeColor.primaryColor, textAlign: TextAlign.center)),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mockdata['data'].length,
            itemBuilder: (context, index) {
              return listProductGroup(
                  icon: 'assets/images/sim.svg',
                  title: compensationData.data[index].product,
                  quantity: '${compensationData.data[index].salesTotal}',
                  unit: compensationData.data[index].unit,
                  seeDetail: true,
                  detail: compensationData.data[index].salesOrder,
                  sum: '${compensationData.data[index].sum}',
                  compensation: true);
            },
          ),
        ],
      ),
    );
  }
}
