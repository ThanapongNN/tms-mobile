import 'package:flutter/cupertino.dart';
import 'package:tms/theme/color.dart';

Widget switchcustom({
  required bool value,
  required void Function(bool)? onChanged,
}) {
  return CupertinoSwitch(
    value: value,
    activeColor: ThemeColor.primaryColor,
    onChanged: onChanged,
  );
}
