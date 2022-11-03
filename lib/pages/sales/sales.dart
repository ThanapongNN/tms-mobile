import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tms/pages/sales/sales_summary.dart';
import 'package:tms/pages/sales/seller_rank.dart';
import 'package:tms/theme/color.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> with TickerProviderStateMixin {
  TabController? _tabBar;

  @override
  void initState() {
    super.initState();
    _tabBar = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text('ยอดขาย'),
        centerTitle: true,
        elevation: 0,
        actions: [IconButton(icon: const Icon(Icons.notifications), onPressed: () {})],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kTextTabBarHeight + MediaQuery.of(context).padding.top),
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: TabBar(
                controller: _tabBar,
                indicator: const BoxDecoration(color: ThemeColor.primaryColor),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                labelStyle: const TextStyle(fontSize: 28, fontFamily: 'Kanit'),
                unselectedLabelStyle: const TextStyle(fontSize: 28, fontFamily: 'Kanit'),
                tabs: const <Tab>[
                  Tab(child: FittedBox(fit: BoxFit.scaleDown, child: Text('สรุปยอดขาย'))),
                  Tab(child: FittedBox(fit: BoxFit.scaleDown, child: Text('อันดับนักขาย'))),
                ],
              ),
            ).paddingAll(20),
          ),
        ),
      ),
      body: TabBarView(controller: _tabBar, children: const [
        SalesSummary(),
        SellerRank(),
      ]),
    );
  }
}
