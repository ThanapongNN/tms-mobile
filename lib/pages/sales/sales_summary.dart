import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/list_sales.dart';

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
          preferredSize: const Size.fromHeight(34),
          child: Container(
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(50)),
              child: TabBar(
                controller: _tabBar,
                // indicator: const BoxDecoration(color: ThemeColor.primaryColor),
                indicator: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)), color: ThemeColor.primaryColor),
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
      body: TabBarView(controller: _tabBar, children: [
        SingleChildScrollView(
          child: SizedBox(
            child: Column(children: [
              listSales(icon: 'assets/images/sim.svg', title: 'ซิม  7-11', content: '0 ซิม'),
              listSales(icon: 'assets/images/sim.svg', title: 'ซิมเติมเงิน', content: '0 ซิม'),
              listSales(icon: 'assets/images/sim.svg', title: 'ซิมรายเดือน', content: '0 ซิม'),
              listSales(icon: 'assets/images/phone_with_sim.svg', title: 'ยอดมือถือ', content: '6 เครื่อง'),
              listSales(icon: 'assets/images/mnp.svg', title: 'ย้ายค่ายเบอร์เดิม', content: '0 เบอร์'),
              listSales(icon: 'assets/images/pretopost.svg', title: 'เติมเงินเป็นรายเดือน', content: '0 เบอร์')
            ]),
          ),
        ),
        SingleChildScrollView(
          child: SizedBox(
            child: Column(children: [
              listSales(icon: 'assets/images/sim.svg', title: 'ซิม  7-11', content: '0 ซิม'),
              listSales(icon: 'assets/images/sim.svg', title: 'ซิมเติมเงิน', content: '0 ซิม'),
              listSales(icon: 'assets/images/sim.svg', title: 'ซิมรายเดือน', content: '0 ซิม'),
              listSales(icon: 'assets/images/phone_with_sim.svg', title: 'ยอดมือถือ', content: '6 เครื่อง'),
              listSales(icon: 'assets/images/mnp.svg', title: 'ย้ายค่ายเบอร์เดิม', content: '0 เบอร์'),
              listSales(icon: 'assets/images/pretopost.svg', title: 'เติมเงินเป็นรายเดือน', content: '0 เบอร์')
            ]),
          ),
        ),
        SingleChildScrollView(
          child: SizedBox(
            child: Column(children: [
              listSales(icon: 'assets/images/sim.svg', title: 'ซิม  7-11', content: '0 ซิม'),
              listSales(icon: 'assets/images/sim.svg', title: 'ซิมเติมเงิน', content: '0 ซิม'),
              listSales(icon: 'assets/images/sim.svg', title: 'ซิมรายเดือน', content: '0 ซิม'),
              listSales(icon: 'assets/images/phone_with_sim.svg', title: 'ยอดมือถือ', content: '6 เครื่อง'),
              listSales(icon: 'assets/images/mnp.svg', title: 'ย้ายค่ายเบอร์เดิม', content: '0 เบอร์'),
              listSales(icon: 'assets/images/pretopost.svg', title: 'เติมเงินเป็นรายเดือน', content: '0 เบอร์')
            ]),
          ),
        ),
      ]),
    );
  }
}
