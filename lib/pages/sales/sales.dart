import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:tms/models/product_group.model.dart';
import 'package:tms/state_management.dart';
import 'package:tms/widgets/box_head_user.dart';
import 'package:tms/widgets/drawer.dart';
import 'package:tms/widgets/list_product_group.dart';
import 'package:tms/widgets/text.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> with SingleTickerProviderStateMixin {
  // late TabController _tabBar;
  bool currentMonthFocus = true;
  List select = ["ยอดขายทั้งหมด"];
  bool turn = true;

  ProductGroupModel productGroupModel = ProductGroupModel.fromJson(Store.productGroup);

  List mockData1 = [
    {"icon": 'assets/images/sim.svg', "title": 'ซิม  7-11', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/sim.svg', "title": 'ซิมเติมเงิน', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/sim.svg', "title": 'ซิมรายเดือน', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/phone_with_sim.svg', "title": 'ยอดมือถือ', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/mnp.svg', "title": 'ย้ายค่ายเบอร์เดิม', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/pretopost.svg', "title": 'เติมเงินเป็นรายเดือน', "quantity": '0', "unit": 'ซิม'},
  ];

  @override
  void initState() {
    super.initState();

    for (var e in productGroupModel.productGroup) {
      select.add(e.product);
    }

    Store.selectedProductGroup.value = select[Store.indexProductGroup.value];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
      drawer: drawer(),
      body: Obx(() {
        return CustomScrollView(slivers: [
          SliverAppBar(
            title: text('ยอดขาย', fontSize: 20),
            centerTitle: true,
            elevation: 0,
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: const Color(0xFF414F5C),
                margin: EdgeInsets.only(top: kToolbarHeight + MediaQuery.of(context).padding.top),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    GestureDetector(
                      onTap: () => setState(() => currentMonthFocus = !currentMonthFocus),
                      child: text(
                        DateFormat('MMMM ${DateTime.now().year + 543}', 'th').format(
                          DateTime.parse('${DateTime.now().year}-${DateTime.now().month - 1}-01').toLocal(),
                        ),
                        color: !currentMonthFocus ? Colors.yellow : Colors.white,
                        decoration: !currentMonthFocus ? null : TextDecoration.underline,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => currentMonthFocus = !currentMonthFocus),
                      child: text(
                        DateFormat('MMMM ${DateTime.now().year + 543}', 'th').format(DateTime.now().toLocal()),
                        color: currentMonthFocus ? Colors.yellow : Colors.white,
                        decoration: currentMonthFocus ? null : TextDecoration.underline,
                      ),
                    ),
                  ]).paddingOnly(bottom: 10),
                  text(
                    DateFormat('ข้อมูลถึงวันที่ dd MMMM ${DateTime.now().year + 543}', 'th').format(DateTime.now().toLocal()),
                    color: Colors.white,
                  ).paddingOnly(bottom: 5),
                  boxHeadUser(name: 'ศนันธฉัตร ธนพัฒน์พิศาล', quantity: '17').paddingOnly(bottom: 15)
                ]).paddingSymmetric(vertical: 15),
              ),
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(15),
                child: Container(
                  color: Colors.white,
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
                )),
          ),
          (Store.indexProductGroup.value == 0)
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: productGroupModel.productGroup.length,
                    (BuildContext context, int index) {
                      return Column(
                        children: productGroupModel.productGroup[index].salesOrder.map((e) {
                          int indexOrder = productGroupModel.productGroup[index].salesOrder.indexOf(e);
                          return listProductGroup(
                            icon: 'assets/images/sim.svg',
                            title: productGroupModel.productGroup[index].salesOrder[indexOrder].order,
                            quantity: productGroupModel.productGroup[index].salesOrder[indexOrder].orderTotal,
                            unit: productGroupModel.productGroup[index].salesOrder[indexOrder].unit,
                            seeDetail: (productGroupModel.productGroup[index].salesOrder[indexOrder].orderTotal == '0') ? false : true,
                            detail: productGroupModel.productGroup[index].salesOrder[indexOrder].serviceCampaign,
                          );
                        }).toList(),
                      );
                    },
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: productGroupModel.productGroup[Store.indexProductGroup.value - 1].salesOrder.length,
                    (BuildContext context, int index) {
                      return listProductGroup(
                        icon: 'assets/images/sim.svg',
                        title: productGroupModel.productGroup[Store.indexProductGroup.value - 1].salesOrder[index].order,
                        quantity: productGroupModel.productGroup[Store.indexProductGroup.value - 1].salesOrder[index].orderTotal,
                        unit: productGroupModel.productGroup[Store.indexProductGroup.value - 1].salesOrder[index].unit,
                        seeDetail:
                            (productGroupModel.productGroup[Store.indexProductGroup.value - 1].salesOrder[index].orderTotal == '0') ? false : true,
                        detail: productGroupModel.productGroup[Store.indexProductGroup.value - 1].salesOrder[index].serviceCampaign,
                      );
                    },
                  ),
                ),
        ]);
      }),
    );
  }
}
