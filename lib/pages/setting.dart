import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tms/widgets/listtile.dart';
import 'package:tms/widgets/switch.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List<bool> switchcheck = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ตั้งค่า')),
      body: Column(
        children: [
          listTile(
            svgicon: 'assets/icons/pinlocation.svg',
            title: 'เข้าใช้งานด้วยรหัส PIN',
            content: 'เข้าใช้งานด้วยรหัส PIN',
            changeMark: true,
            trailing: switchcustom(
              value: switchcheck[0],
              onChanged: (v) {
                setState(
                  () {
                    switchcheck[0] = v;
                  },
                );
              },
            ),
          ),
          listTile(
            svgicon: 'assets/icons/Person.svg',
            title: 'เข้าใช้งานด้วยรหัส PIN',
            content: 'เข้าใช้งานด้วยรหัส PIN',
            changeMark: true,
            trailing: switchcustom(
              value: switchcheck[1],
              onChanged: (v) {
                setState(
                  () {
                    switchcheck[1] = v;
                  },
                );
              },
            ),
          ),
          listTile(
            svgicon: 'assets/icons/Bell.svg',
            title: 'เข้าใช้งานด้วยรหัส PIN',
            changeMark: true,
            trailing: switchcustom(
              value: switchcheck[2],
              onChanged: (v) {
                setState(
                  () {
                    switchcheck[2] = v;
                  },
                );
              },
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }
}
