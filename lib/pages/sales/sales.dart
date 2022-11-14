import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:tms/pages/sales/internet.dart';
import 'package:tms/pages/sales/sim.dart';
import 'package:tms/pages/sales/topup.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/box_head_user.dart';
import 'package:tms/widgets/drawer.dart';
import 'package:tms/widgets/text.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> with SingleTickerProviderStateMixin {
  late TabController _tabBar;

  bool currentMonthFocus = true;

  @override
  void initState() {
    super.initState();
    _tabBar = TabController(length: 3, vsync: this);
    _tabBar.addListener(() {
      setState(() {});
    });
  }

  List mockData1 = [
    {"icon": 'assets/images/sim.svg', "title": 'ซิม  7-11', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/sim.svg', "title": 'ซิมเติมเงิน', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/sim.svg', "title": 'ซิมรายเดือน', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/phone_with_sim.svg', "title": 'ยอดมือถือ', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/mnp.svg', "title": 'ย้ายค่ายเบอร์เดิม', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/pretopost.svg', "title": 'เติมเงินเป็นรายเดือน', "quantity": '0', "unit": 'ซิม'},
  ];

  List mockData2 = [
    {"icon": 'assets/images/sim.svg', "title": 'ซิมรายเดือน', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/phone_with_sim.svg', "title": 'ยอดมือถือ', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/mnp.svg', "title": 'ย้ายค่ายเบอร์เดิม', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/pretopost.svg', "title": 'เติมเงินเป็นรายเดือน', "quantity": '0', "unit": 'ซิม'},
  ];

  List mockData3 = [
    {"icon": 'assets/images/mnp.svg', "title": 'ย้ายค่ายเบอร์เดิม', "quantity": '0', "unit": 'ซิม'},
    {"icon": 'assets/images/pretopost.svg', "title": 'เติมเงินเป็นรายเดือน', "quantity": '0', "unit": 'ซิม'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
      drawer: drawer(),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: text('ยอดขาย', fontSize: 20),
          centerTitle: true,
          elevation: 0,
          pinned: true,
          expandedHeight: 340,
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
          bottom: AppBar(
            leadingWidth: 0,
            titleSpacing: 0,
            elevation: 1,
            backgroundColor: Colors.white,
            toolbarHeight: kToolbarHeight + MediaQuery.of(context).padding.top,
            title: Container(
              width: double.infinity,
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(50)),
                child: TabBar(
                  controller: _tabBar,
                  indicator: ShapeDecoration(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    color: ThemeColor.primaryColor,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelStyle: const TextStyle(fontSize: 28, fontFamily: 'Kanit'),
                  unselectedLabelStyle: const TextStyle(fontSize: 28, fontFamily: 'Kanit'),
                  tabs: const <Tab>[
                    Tab(child: FittedBox(fit: BoxFit.scaleDown, child: Text('เบอร์และมือถือ'))),
                    Tab(child: FittedBox(fit: BoxFit.scaleDown, child: Text('เติมเงินเติมเน็ต'))),
                    Tab(child: FittedBox(fit: BoxFit.scaleDown, child: Text('เน็ตบ้านและทีวี'))),
                  ],
                ),
              ).paddingAll(20),
            ),
          ),
        ),
        if (_tabBar.index == 0) SalesSim(data: mockData1),
        if (_tabBar.index == 1) SalesTopup(data: mockData2),
        if (_tabBar.index == 2) SalesInternet(data: mockData3),
      ]),
    );
  }
}
