import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:tms/pages/sales/sales_summary.dart';
import 'package:tms/state_management.dart';
import 'package:tms/widgets/box_head_user.dart';
import 'package:tms/widgets/drawer.dart';
import 'package:tms/widgets/text.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ยอดขาย'),
        centerTitle: true,
        elevation: 0,
      ),
      onDrawerChanged: (isOpened) => Store.drawer.value = isOpened,
      drawer: drawer(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF414F5C),
            child: Column(
              children: [
                text(text: 'สรุปยอดขายของคุณ', color: Colors.white),
                const SizedBox(height: 5),
                text(
                  text: DateFormat('ข้อมูลถึงวันที่ dd MMMM ${DateTime.now().year + 543}', 'th').format(DateTime.now().toLocal()),
                  color: Colors.white,
                ),
                const SizedBox(height: 15),
                boxHeadUser(name: 'ศนันธฉัตร ธนพัฒน์พิศาล', quantity: '17')
              ],
            ).paddingSymmetric(vertical: 15),
          ),
          const Expanded(child: SalesSummary()),
        ],
      ),
    );
  }
}
