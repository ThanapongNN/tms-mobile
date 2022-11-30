import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/text.dart';

class NoDataPage extends StatelessWidget {
  final void Function()? onPressed;
  const NoDataPage({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      text('การเข้าถึงข้อมูลมีปัญหา\nกรุณากดรีโหลดเพื่อดำเนินการต่อ', color: Colors.black54, fontSize: 24, textAlign: TextAlign.center),
      const SizedBox(height: 10),
      MaterialButton(
        height: 50,
        color: Colors.white,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: ThemeColor.primaryColor),
        ),
        onPressed: onPressed,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Icon(BootstrapIcons.arrow_clockwise, color: ThemeColor.primaryColor, size: 32),
          SizedBox(width: 5),
          Text('รีโหลด', style: TextStyle(fontSize: 24, color: ThemeColor.primaryColor, decoration: TextDecoration.underline)),
        ]),
      ).paddingSymmetric(horizontal: 60),
    ]).paddingAll(60);
  }
}
