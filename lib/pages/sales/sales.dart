import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:tms/apis/request/first_login.request.dart';
import 'package:tms/pages/no_data.dart';
import 'package:tms/pages/sales/compensation.dart';
import 'package:tms/pages/sales/sales_total.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/ga_log.dart';
import 'package:tms/widgets/box_head_user.dart';
import 'package:tms/widgets/drawer.dart';
import 'package:tms/widgets/text.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> with SingleTickerProviderStateMixin {
  final GlobalKey _keyRow = GlobalKey();
  final GlobalKey _keyText = GlobalKey();
  final GlobalKey _keyBoxHeadUser = GlobalKey();

  late TabController _tabBar;

  bool turn = true;

  List<bool> currentMonthFocus = [];
  List select = ["ยอดขายทั้งหมด"];

  @override
  void initState() {
    super.initState();
    GALog.content('sales-view');

    _tabBar = TabController(length: 2, vsync: this);
    _tabBar.addListener(() => setState(() {}));

    if (Store.productGroup.isNotEmpty) {
      for (var e in Store.productGroup['data'][Store.indexMonth.value]['productGroup']) {
        select.add(e['product']);
      }

      //เซ็ตสีเลือกเดือน
      currentMonthFocus = Store.productGroup['data']
          .map<bool>(
            (e) => Store.indexMonth.value == Store.productGroup['data'].indexOf(e),
          )
          .toList();

      Store.selectedProductGroup.value = select[Store.indexProductGroup.value];
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Timer.periodic(
        const Duration(milliseconds: 250),
        (Timer t) {
          if (Store.productGroup.isNotEmpty) {
            t.cancel();
            if ((Store.heightSliverAppBar.value == 0) && (_keyRow.currentContext != null)) {
              Store.heightSliverAppBar.value =
                  94 + _keyRow.currentContext!.size!.height + _keyText.currentContext!.size!.height + _keyBoxHeadUser.currentContext!.size!.height;
            }
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SvgPicture.asset('assets/images/head_appbar.svg', width: 100), toolbarHeight: kToolbarHeight + 1),
      onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
      drawer: drawer(),
      body: (Store.productGroup.isNotEmpty)
          ? Obx(() {
              return CustomScrollView(slivers: [
                SliverAppBar(
                  leading: const SizedBox(),
                  actions: null,
                  pinned: true,
                  expandedHeight: Store.heightSliverAppBar.value,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: const Color(0xFF414F5C),
                      child: ListView(children: [
                        Row(
                          key: _keyRow,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: Store.productGroup['data']
                              .map<Widget>((e) {
                                int index = Store.productGroup['data'].indexOf(e);
                                return GestureDetector(
                                  onTap: () => setState(() {
                                    currentMonthFocus = Store.productGroup['data'].map<bool>((e) => false).toList();
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
                        ).paddingSymmetric(vertical: 10),
                        Center(
                          key: _keyText,
                          child: text(
                            DateFormat('ข้อมูลถึงวันที่ dd/MM/${DateTime.now().year + 543}', 'th').format(DateTime.now().toLocal()),
                            color: Colors.white,
                          ).paddingSymmetric(vertical: 10),
                        ),
                        Center(
                          key: _keyBoxHeadUser,
                          child: boxHeadUser(
                            name:
                                'คุณ${Store.userAccountModel!.value.account.employee.name} ${Store.userAccountModel!.value.account.employee.surname}',
                            title: Store.selectedProductGroup.value,
                            quantity: (select.indexOf(Store.selectedProductGroup.value) == 0)
                                ? '${Store.productGroup['data'][Store.indexMonth.value]['totalCount']}'
                                : '${Store.productGroup['data'][Store.indexMonth.value]['productGroup'][select.indexOf(Store.selectedProductGroup.value) - 1]['salesTotal']}',
                          ).paddingOnly(bottom: 15),
                        ),
                      ]),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(15),
                    child: Container(
                      color: const Color(0xFFCED4DA),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                        child: TabBar(
                          controller: _tabBar,
                          indicator: ShapeDecoration(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            color: ThemeColor.primaryColor,
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          labelStyle: const TextStyle(fontSize: 20, fontFamily: 'Kanit'),
                          unselectedLabelStyle: const TextStyle(fontSize: 20, fontFamily: 'Kanit'),
                          tabs: <Tab>[
                            Tab(
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/images/cash.svg',
                                            width: 30, color: (_tabBar.index == 0) ? Colors.white : Colors.black),
                                        const SizedBox(width: 5),
                                        const Text('ยอดขายทั้งหมด'),
                                      ],
                                    ))),
                            Tab(
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/gift.svg',
                                          width: 30,
                                          color: (_tabBar.index == 1) ? Colors.white : Colors.black,
                                        ),
                                        const SizedBox(width: 5),
                                        const Text('ผลตอบแทนทั้งหมด'),
                                      ],
                                    ))),
                          ],
                        ).paddingAll(5),
                      ).paddingSymmetric(vertical: 5, horizontal: 30),
                    ),
                  ),
                ),
                if (_tabBar.index == 0) const SalesTotal(),
                if (_tabBar.index == 1) const Compensation(),
                const SliverToBoxAdapter(child: SizedBox(height: 20))
              ]);
            })
          : NoDataPage(onPressed: () async {
              await firstLoginRequest();
              setState(() {
                if (Store.productGroup.isNotEmpty) {
                  for (var e in Store.productGroup['data'][Store.indexMonth.value]['productGroup']) {
                    select.add(e['product']);
                  }

                  //เซ็ตสีเลือกเดือน
                  currentMonthFocus = Store.productGroup['data']
                      .map<bool>((e) => Store.productGroup['data'].length == (Store.productGroup['data'].indexOf(e) + 1))
                      .toList()
                      .reversed
                      .toList();

                  Store.selectedProductGroup.value = select[Store.indexProductGroup.value];
                }
              });
            }),
    );
  }
}
