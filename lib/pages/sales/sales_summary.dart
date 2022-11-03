import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tms/theme/color.dart';

class SalesSummary extends StatefulWidget {
  const SalesSummary({super.key});

  @override
  State<SalesSummary> createState() => _SalesSummaryState();
}

class _SalesSummaryState extends State<SalesSummary> with TickerProviderStateMixin {
  TabController? _tabBar;

  @override
  void initState() {
    super.initState();
    _tabBar = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kTextTabBarHeight + MediaQuery.of(context).padding.top),
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: TabBar(
                controller: _tabBar,
                indicator: const BoxDecoration(color: ThemeColor.primaryColor),
                labelColor: Colors.black,
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
      body: TabBarView(controller: _tabBar, children: const [
        SizedBox(),
        SizedBox(),
        SizedBox(),
      ]),
    );
  }
}
