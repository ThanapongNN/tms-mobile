import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';

Future navigatorTo(Function() page, {Transition? transition}) async {
  await EasyLoading.show();
  await Future.delayed(const Duration(milliseconds: 200));
  Get.to(page, transition: transition);
  await EasyLoading.dismiss();
}

Future navigatorOff(Function() page, {Transition? transition}) async {
  await EasyLoading.show();
  await Future.delayed(const Duration(milliseconds: 200));
  Get.off(page, transition: transition);
  await EasyLoading.dismiss();
}

Future navigatorOffAll(Function() page, {Transition? transition}) async {
  await EasyLoading.show();
  await Future.delayed(const Duration(milliseconds: 200));
  Get.offAll(page, transition: transition);
  await EasyLoading.dismiss();
}

void navigatorBack({Object? result}) {
  Get.back(result: result);
}
