import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tms/state_management.dart';
import 'package:tms/pages/home.dart';
import 'package:tms/pages/information.dart';
import 'package:tms/pages/sale.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _currentIndex = 0;
  List<Widget> taps = [];

  @override
  void initState() {
    super.initState();

    taps = [const Home(), const Sale(), const Information()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return SafeArea(
        top: false,
        child: Stack(
          children: [
            Padding(
              padding: (!Store.drawer.value) ? const EdgeInsets.only(bottom: 70) : EdgeInsets.zero,
              child: taps[_currentIndex],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: (!Store.drawer.value) ? 70 : 0,
                  decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
                  child: BottomNavigationBar(
                      currentIndex: _currentIndex,
                      type: BottomNavigationBarType.fixed,
                      onTap: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      items: const [
                        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
                        BottomNavigationBarItem(icon: Icon(Icons.signal_cellular_alt), label: 'ยอดขาย'),
                        BottomNavigationBarItem(icon: Icon(Icons.campaign), label: 'ข่าวสาร'),
                      ]),
                ))
          ],
        ),
      );
    }));
  }
}
