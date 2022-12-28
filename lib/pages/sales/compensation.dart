import 'package:flutter/material.dart';
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
  CompensationData compensationData = CompensationData.fromJson(Store.compersationData);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(children: [
        text('*ผลตอบแทนทั้งหมดเป็นเพียงแค่ยอดประมาณการ', color: ThemeColor.primaryColor),
        Column(
          children: Store.productGroup['data'][Store.indexMonth.value]['commission'].map<Widget>((commission) {
            return listProductGroup(
              icon: commission['iconName'],
              title: commission['name'],
              quantity: '${commission['total']}',
              seeDetail: !(commission['total'] == 0),
              unit: commission['unit'] ?? 'เครื่อง',
              detail: commission['list'],
            );
          }).toList(),
        ),
      ]),
    );
  }
}
