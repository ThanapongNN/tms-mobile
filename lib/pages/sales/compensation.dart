import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(children: [
        text('*ยอดโดยประมาณการการคำนวณผลตอบแทน\nเป็นไปตามเงื่อนไขที่บริษัทกำหนด',
                fontSize: 19, color: ThemeColor.primaryColor, textAlign: TextAlign.center)
            .paddingSymmetric(vertical: 5),
        Column(
          children: Store.productGroupModel!.value.data![Store.indexMonth.value]!.commission!.map<Widget>((commission) {
            return listProductGroup(
              icon: commission!.iconName!,
              title: commission.name!,
              quantity: '${commission.total}',
              seeDetail: !(commission.total == 0),
              unit: commission.unit!,
              detail: commission.list,
              sum: commission.summary,
              compensation: true,
            );
          }).toList(),
        ),
      ]),
    );
  }
}
