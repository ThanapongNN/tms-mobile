import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms/state_management.dart';
import 'package:tms/widgets/list_product_group.dart';

class SalesTotal extends StatefulWidget {
  const SalesTotal({super.key});

  @override
  State<SalesTotal> createState() => _SalesTotalState();
}

class _SalesTotalState extends State<SalesTotal> {
  int indexMonth = 0;
  List select = ["ยอดขายทั้งหมด"];
  List<Widget> showProducts = [];

  @override
  void initState() {
    super.initState();
    showProducts.clear();

    if (Store.productGroup.isNotEmpty) {
      for (var e in Store.productGroup['data'][Store.indexMonth.value]['productGroup']) {
        select.add(e['product']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverToBoxAdapter(
        child: Column(children: [
          Container(
            color: const Color(0xFFF8F9FA),
            width: double.infinity,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: [
                    const SizedBox(width: 4),
                    Expanded(
                      child: Center(
                        child: Text(
                          'เลือกดูแบบ : ${Store.selectedProductGroup.value}',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                items: select
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item, style: const TextStyle(fontSize: 14, color: Colors.black), overflow: TextOverflow.ellipsis),
                        ))
                    .toList(),
                onChanged: (value) {
                  Store.selectedProductGroup.value = value!;
                  Store.indexProductGroup.value = select.indexOf(value);
                },
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 30,
                iconEnabledColor: Colors.white,
                buttonHeight: 50,
                buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                buttonDecoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: const Color(0xFFE44160)),
              ),
            ).paddingSymmetric(horizontal: 20, vertical: 10),
          ),
          (Store.indexProductGroup.value == 0)
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Store.productGroup['data'][Store.indexMonth.value]['productGroup'].length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: Store.productGroup['data'][Store.indexMonth.value]['productGroup'][index]['salesOrder'].map<Widget>((e) {
                        int indexOrder = Store.productGroup['data'][Store.indexMonth.value]['productGroup'][index]['salesOrder'].indexOf(e);
                        return listProductGroup(
                          icon:
                              (Store.productGroup['data'][Store.indexMonth.value]['productGroup'][index]['salesOrder'][indexOrder]['unit'] == 'เบอร์')
                                  ? 'assets/images/sim.svg'
                                  : 'assets/images/phone_with_sim.svg',
                          title: Store.productGroup['data'][Store.indexMonth.value]['productGroup'][index]['salesOrder'][indexOrder]['order'],
                          quantity:
                              '${Store.productGroup['data'][Store.indexMonth.value]['productGroup'][index]['salesOrder'][indexOrder]['orderTotal']}',
                          unit: Store.productGroup['data'][Store.indexMonth.value]['productGroup'][index]['salesOrder'][indexOrder]['unit'],
                          seeDetail: !(Store.productGroup['data'][Store.indexMonth.value]['productGroup'][index]['salesOrder'][indexOrder]
                                  ['orderTotal'] ==
                              0),
                          detail: Store.productGroup['data'][Store.indexMonth.value]['productGroup'][index]['salesOrder'][indexOrder]
                              ['serviceCampaign'],
                        );
                      }).toList(),
                    );
                  },
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      Store.productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]['salesOrder'].length,
                  itemBuilder: (context, index) {
                    return listProductGroup(
                      icon: (Store.productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]['salesOrder']
                                  [index]['unit'] ==
                              'เบอร์')
                          ? 'assets/images/sim.svg'
                          : 'assets/images/phone_with_sim.svg',
                      title: Store.productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]['salesOrder']
                          [index]['order'],
                      quantity:
                          '${Store.productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]['salesOrder'][index]['orderTotal']}',
                      unit: Store.productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]['salesOrder'][index]
                          ['unit'],
                      seeDetail: !(Store.productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]['salesOrder']
                              [index]['orderTotal'] ==
                          0),
                      detail: Store.productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]['salesOrder']
                          [index]['serviceCampaign'],
                    );
                  },
                ),
        ]),
      ),
    );
  }
}
