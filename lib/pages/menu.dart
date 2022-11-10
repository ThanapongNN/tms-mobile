import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tms/state_management.dart';
import 'package:tms/pages/home.dart';
import 'package:tms/pages/sales/sales.dart';
import 'package:tms/pages/news/news.dart';
import 'package:tms/theme/color.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Widget> taps = [const Home(), const SalesPage(), const NewsPage()];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(top: false, child: taps[Store.currentIndex.value]),
        bottomNavigationBar: (!Store.drawer.value)
            ? BottomNavigationBar(
                currentIndex: Store.currentIndex.value,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 16,
                unselectedFontSize: 14,
                backgroundColor: Colors.white,
                items: [
                  const BottomNavigationBarItem(label: 'หน้าหลัก', icon: Icon(BootstrapIcons.house)),
                  const BottomNavigationBarItem(label: 'ยอดขาย', icon: Icon(BootstrapIcons.graph_up_arrow)),
                  BottomNavigationBarItem(
                    label: 'ข่าวสาร',
                    icon: SvgPicture.asset(
                      'assets/icons/megaphone.svg',
                      width: 24,
                      color: (Store.currentIndex.value == 2) ? ThemeColor.primaryColor : null,
                    ),
                  ),
                ],
                onTap: (index) => Store.currentIndex.value = index,
              )
            : null,
      );
    });
  }
}
