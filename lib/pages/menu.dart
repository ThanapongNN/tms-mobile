import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tms/state_management.dart';
import 'package:tms/pages/home.dart';
import 'package:tms/pages/sales.dart';
import 'package:tms/pages/news.dart';

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
                iconSize: 32,
                selectedFontSize: 16,
                unselectedFontSize: 14,
                backgroundColor: Colors.white,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
                  BottomNavigationBarItem(icon: Icon(Icons.signal_cellular_alt), label: 'ยอดขาย'),
                  BottomNavigationBarItem(icon: Icon(Icons.campaign), label: 'ข่าวสาร'),
                ],
                onTap: (index) => Store.currentIndex.value = index,
              )
            : null,
      );
    });
  }
}
