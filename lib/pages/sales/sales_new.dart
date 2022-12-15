import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:tms/apis/request/product_group.request.dart';
import 'package:tms/pages/no_data.dart';
import 'package:tms/pages/sales/compensation.dart';
import 'package:tms/pages/sales/sales_total.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/box_head_user.dart';
import 'package:tms/widgets/drawer.dart';
import 'package:tms/widgets/text.dart';

class SalesPageNew extends StatefulWidget {
  const SalesPageNew({super.key});

  @override
  State<SalesPageNew> createState() => _SalesPageNewState();
}

class _SalesPageNewState extends State<SalesPageNew> with SingleTickerProviderStateMixin {
  late TabController _tabBar;
  bool turn = true;

  List<bool> currentMonthFocus = [];
  List select = ["ยอดขายทั้งหมด"];

  @override
  void initState() {
    super.initState();

    _tabBar = TabController(length: 2, vsync: this);
    _tabBar.addListener(() {
      setState(() {});
    });
    if (Store.productGroupModel != null) {
      for (var e in Store.productGroupModel!.value.data[Store.indexMonth.value].productGroup) {
        select.add(e.product);
      }

      //เซ็ตสีเลือกเดือน
      currentMonthFocus = Store.productGroupModel!.value.data
          .map((e) => Store.productGroupModel!.value.data.length == (Store.productGroupModel!.value.data.indexOf(e) + 1))
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
      body: (Store.productGroupModel != null)
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
                          children: Store.productGroupModel!.value.data
                              .map((e) {
                                int index = Store.productGroupModel!.value.data.indexOf(e);
                                return GestureDetector(
                                  onTap: () => setState(() {
                                    currentMonthFocus = Store.productGroupModel!.value.data.map((e) => false).toList();
                                    currentMonthFocus[index] = true;
                                    Store.indexMonth.value = currentMonthFocus.indexOf(true);
                                  }),
                                  child: text(
                                    DateFormat(
                                      'MMMM ${DateTime.parse('${Store.productGroupModel!.value.data[index].strDate}-01').year + 543}',
                                      'th',
                                    ).format(DateTime.parse('${Store.productGroupModel!.value.data[index].strDate}-01').toLocal()),
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
                            'ข้อมูลถึงวันที่ dd MMMM ${Store.productGroupModel!.value.data[Store.indexMonth.value].lastUpdate.year + 543}',
                            'th',
                          ).format(Store.productGroupModel!.value.data[Store.indexMonth.value].lastUpdate.toLocal()),
                          color: Colors.white,
                        ).paddingOnly(bottom: 5),
                        boxHeadUser(
                          name: 'คุณ${Store.userAccountModel!.value.account.employee.name} ${Store.userAccountModel!.value.account.employee.surname}',
                          title: Store.selectedProductGroup.value,
                          quantity: (select.indexOf(Store.selectedProductGroup.value) == 0)
                              ? '${Store.productGroupModel!.value.data[Store.indexMonth.value].totalCount}'
                              : '${Store.productGroupModel!.value.data[Store.indexMonth.value].productGroup[select.indexOf(Store.selectedProductGroup.value) - 1].salesTotal}',
                        ).paddingOnly(bottom: 15)
                      ]).paddingSymmetric(vertical: 15),
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
                                        SvgPicture.asset('assets/icons/cash.svg',
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
                                          'assets/icons/gift.svg',
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
              ]);
            })
          : Column(children: [
              AppBar(title: SvgPicture.asset('assets/images/head_appbar.svg', width: 100)),
              NoDataPage(onPressed: () async {
                await callFirstLogin(Store.encryptedEmployeeId.value);
                setState(() {
                  if (Store.productGroupModel != null) {
                    for (var e in Store.productGroupModel!.value.data[Store.indexMonth.value].productGroup) {
                      select.add(e.product);
                    }

                    //เซ็ตสีเลือกเดือน
                    currentMonthFocus = Store.productGroupModel!.value.data
                        .map((e) => Store.productGroupModel!.value.data.length == (Store.productGroupModel!.value.data.indexOf(e) + 1))
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
