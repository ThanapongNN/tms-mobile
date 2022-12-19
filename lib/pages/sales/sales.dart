import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:tms/apis/request/first_login.request.dart';
import 'package:tms/pages/no_data.dart';
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
  bool turn = true;

  List<bool> currentMonthFocus = [];
  List select = ["ยอดขายทั้งหมด"];

  @override
  void initState() {
    super.initState();

    if (Store.productGroup.isNotEmpty) {
      for (var e in Store.productGroup['data'][Store.indexMonth.value]['productGroup']) {
        select.add(e['product']);
      }

      //เซ็ตสีเลือกเดือน
      currentMonthFocus = Store.productGroup['data']
          .map((e) => Store.productGroup['data'].length == (Store.productGroup['data'].indexOf(e) + 1))
          .toList()
          .reversed
          .toList();

      Store.selectedProductGroup.value = select[Store.indexProductGroup.value];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
      drawer: drawer(),
      body: (Store.productGroup.isNotEmpty)
          ? Obx(() {
              return CustomScrollView(slivers: [
                SliverAppBar(
                  leading: const SizedBox(),
                  actions: null,
                  centerTitle: true,
                  elevation: 0,
                  pinned: true,
                  expandedHeight: 310,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: const Color(0xFF414F5C),
                      // margin: EdgeInsets.only(top: kToolbarHeight + MediaQuery.of(context).padding.top),
                      child: Column(children: [
                        AppBar(
                          title: SvgPicture.asset('assets/images/head_appbar.svg', width: 110).paddingOnly(bottom: 10),
                          elevation: 0,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: Store.productGroup['data']
                              .map((e) {
                                int index = Store.productGroup['data'].indexOf(e);
                                return GestureDetector(
                                  onTap: () => setState(() {
                                    currentMonthFocus = Store.productGroup['data'].map((e) => false).toList();
                                    currentMonthFocus[index] = true;
                                    Store.indexMonth.value = currentMonthFocus.indexOf(true);
                                  }),
                                  child: text(
                                    DateFormat(
                                      'MMMM ${DateTime.parse('${Store.productGroup['data'][index]['strDate']}-01').year + 543}',
                                      'th',
                                    ).format(DateTime.parse('${Store.productGroup['data'][index]['strDate']}-01').toLocal()),
                                    color: currentMonthFocus[index] ? Colors.yellow : Colors.white,
                                    decoration: currentMonthFocus[index] ? TextDecoration.underline : null,
                                  ),
                                );
                              })
                              .toList() //แปลงเป็น Array
                              .reversed //เรียงจากหลังไปหน้า
                              .toList(), //แปลงกลับเป็น Array
                        ).paddingOnly(bottom: 10),
                        text(
                          DateFormat(
                            'ข้อมูลถึงวันที่ dd MMMM ${Store.productGroup['data'][Store.indexMonth.value]['lastUpdate'].year + 543}',
                            'th',
                          ).format(Store.productGroup['data'][Store.indexMonth.value]['lastUpdate'].toLocal()),
                          color: Colors.white,
                        ).paddingOnly(bottom: 5),
                        boxHeadUser(
                          name: 'คุณ${Store.userAccountModel!.value.account.employee.name} ${Store.userAccountModel!.value.account.employee.surname}',
                          title: Store.selectedProductGroup.value,
                          quantity: (select.indexOf(Store.selectedProductGroup.value) == 0)
                              ? '${Store.productGroup['data'][Store.indexMonth.value]['totalCount']}'
                              : '${Store.productGroup['data'][Store.indexMonth.value]['productGroup'][select.indexOf(Store.selectedProductGroup.value) - 1]['salesTotal']}',
                        ).paddingOnly(bottom: 15)
                      ]).paddingSymmetric(vertical: 15),
                    ),
                  ),
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(15),
                      child: Container(
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
                      )),
                ),
                (Store.indexProductGroup.value == 0)
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: Store.productGroup['data'][Store.indexMonth.value]['productGroup'].length,
                          (BuildContext context, int index) {
                            return Column(
                              children: Store.productGroup['data'][Store.indexMonth.value]['productGroup'][index]['salesOrder'].map((e) {
                                int indexOrder = Store.productGroup['data'][Store.indexMonth.value]['productGroup'][index]['salesOrder'].indexOf(e);
                                return listProductGroup(
                                  icon: (Store.productGroup['data'][Store.indexMonth.value]['productGroup'][index]['salesOrder'][indexOrder]
                                              ['unit'] ==
                                          'เบอร์')
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
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: Store
                              .productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]['salesOrder'].length,
                          (BuildContext context, int index) {
                            return listProductGroup(
                              icon: (Store.productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]
                                          .salesOrder[index]['unit'] ==
                                      'เบอร์')
                                  ? 'assets/images/sim.svg'
                                  : 'assets/images/phone_with_sim.svg',
                              title: Store.productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]
                                  ['salesOrder'][index]['order'],
                              quantity:
                                  '${Store.productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]['salesOrder'][index]['orderTotal']}',
                              unit: Store.productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]
                                  ['salesOrder'][index]['unit'],
                              seeDetail: !(Store.productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]
                                      ['salesOrder'][index]['orderTotal'] ==
                                  0),
                              detail: Store.productGroup['data'][Store.indexMonth.value]['productGroup'][Store.indexProductGroup.value - 1]
                                  ['salesOrder'][index]['serviceCampaign'],
                            );
                          },
                        ),
                      ),
              ]);
            })
          : Column(children: [
              AppBar(title: SvgPicture.asset('assets/images/head_appbar.svg', width: 100)),
              NoDataPage(onPressed: () async {
                await firstLoginRequest(Store.encryptedEmployeeId.value);
                setState(() {
                  if (Store.productGroup.isNotEmpty) {
                    for (var e in Store.productGroup['data'][Store.indexMonth.value]['productGroup']) {
                      select.add(e['product']);
                    }

                    //เซ็ตสีเลือกเดือน
                    currentMonthFocus = Store.productGroup['data']
                        .map((e) => Store.productGroup['data'].length == (Store.productGroup['data'].indexOf(e) + 1))
                        .toList()
                        .reversed
                        .toList();

                    Store.selectedProductGroup.value = select[Store.indexProductGroup.value];
                  }
                });
              }),
            ]),
    );
  }
}
