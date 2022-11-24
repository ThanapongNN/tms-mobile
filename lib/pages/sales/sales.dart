import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
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
  int _currentPage = 0;
  bool currentMonthFocus = true;
  List select = ["ยอดขายทั้งหมด"];
  String? selectedValue;
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
    selectedValue = select[0];

    for (var e in productGroupModel.productGroup) {
      select.add(e.product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
      drawer: drawer(),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: text('ยอดขาย (MOCK)', fontSize: 20),
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
          // bottom: AppBar(
          //   leadingWidth: 0,
          //   titleSpacing: 0,
          //   elevation: 1,
          //   backgroundColor: Colors.white,
          //   toolbarHeight: kToolbarHeight + MediaQuery.of(context).padding.top,
          //   title: Container(
          //     width: double.infinity,
          //     color: Colors.white,
          //     child: Container(
          //       decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(50)),
          //       child: TabBar(
          //         controller: _tabBar,
          //         indicator: ShapeDecoration(
          //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          //           color: ThemeColor.primaryColor,
          //         ),
          //         labelColor: Colors.white,
          //         unselectedLabelColor: Colors.black,
          //         labelStyle: const TextStyle(fontSize: 28, fontFamily: 'Kanit'),
          //         unselectedLabelStyle: const TextStyle(fontSize: 28, fontFamily: 'Kanit'),
          //         tabs: const <Tab>[
          //           Tab(child: FittedBox(fit: BoxFit.scaleDown, child: Text('เบอร์และมือถือ'))),
          //           Tab(child: FittedBox(fit: BoxFit.scaleDown, child: Text('เติมเงินเติมเน็ต'))),
          //           Tab(child: FittedBox(fit: BoxFit.scaleDown, child: Text('เน็ตบ้านและทีวี'))),
          //         ],
          //       ),
          //     ).paddingAll(20),
          //   ),
          // ),
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
                              'เลือกดูแบบ : $selectedValue',
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
                      setState(() {
                        selectedValue = value;
                        Store.selectProductGroup.value = select.indexOf(value);
                        print(Store.selectProductGroup.value);
                      });
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

        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: productGroupModel.productGroup[Store.selectProductGroup.value].salesOrder.length,
            (BuildContext context, int index) {
              return listProductGroup(
                icon: 'assets/images/sim.svg',
                title: productGroupModel.productGroup[Store.selectProductGroup.value].salesOrder[index].order,
                quantity: productGroupModel.productGroup[Store.selectProductGroup.value].salesOrder[index].orderTotal,
                unit: productGroupModel.productGroup[Store.selectProductGroup.value].salesOrder[index].unit,
                seeDetail: (productGroupModel.productGroup[Store.selectProductGroup.value].salesOrder[index].orderTotal == '0') ? false : true,
                detail: productGroupModel.productGroup[Store.selectProductGroup.value].salesOrder[index].serviceCampaign,
              );
            },
          ),
        ),

        // if (_currentPage == 0) productGroupPage(data: productGroupModel.productGroup[0].salesOrder),
        // if (_currentPage == 1) productGroupPage(data: productGroupModel.productGroup[1].salesOrder),
        // if (_tabBar.index == 0) SalesSim(data: mockData1),
        // if (_tabBar.index == 1) SalesTopup(data: mockData2),
        // if (_tabBar.index == 2) SalesInternet(data: mockData3),
      ]),
    );
  }
}
