import 'package:get/get_rx/src/rx_types/rx_types.dart';

//ตัวแปรกองกลาง
class Store {
  static RxBool drawer = false.obs;

  static RxInt currentIndex = 0.obs;

  static RxString version = ''.obs;
}
