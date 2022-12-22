import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tms/pages/learning/learning.dart';
import 'package:tms/pages/sales/sales.dart';
import 'package:tms/state_management.dart';
import 'package:tms/pages/home.dart';
import 'package:tms/pages/news/news.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/custom_icons_icons.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Widget> taps = [
    const Home(),
    const SalesPage(),
    const NewsPage(),
    const LearningPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(top: false, child: taps[Store.currentIndex.value]),
        bottomNavigationBar: (!Store.drawer.value)
            ? CustomLineIndicatorBottomNavbar(
                selectedColor: ThemeColor.primaryColor,
                unSelectedColor: Colors.black54,
                backgroundColor: Colors.white,
                currentIndex: Store.currentIndex.value,
                selectedIconSize: 20,
                unselectedIconSize: 20,
                selectedFontSize: 14,
                unselectedFontSize: 12,
                onTap: (index) => Store.currentIndex.value = index,
                customBottomBarItems: [
                  CustomBottomBarItems(label: 'หน้าหลัก', icon: BootstrapIcons.house),
                  CustomBottomBarItems(label: 'ยอดขาย', icon: BootstrapIcons.graph_up_arrow),
                  CustomBottomBarItems(label: 'ข่าวและแคมเปญ', icon: CustomIcons.megaphone),
                  CustomBottomBarItems(label: 'การเรียนรู้', icon: CustomIcons.education),
                ],
              )
            : null,
      );
    });
  }
}
