import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:tms/state_management.dart';

Future<void> getDeviceSerial() async {
  try {
    if (Platform.isAndroid) {
      var data = await DeviceInfoPlugin().androidInfo;
      Store.deviceSerial.value = data.id;
    } else if (Platform.isIOS) {
      var data = await DeviceInfoPlugin().iosInfo;
      Store.deviceSerial.value = data.identifierForVendor!;
    }
  } on PlatformException {
    Store.deviceSerial.value = '';
  }
}
