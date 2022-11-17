import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tms/models/user_account.model.dart';

//ตัวแปรกองกลาง
class Store {
  static RxBool drawer = false.obs;

  static RxInt currentIndex = 0.obs;

  static RxMap<String, dynamic> partnerTypes = <String, dynamic>{}.obs;
  static RxMap<String, dynamic> userAccount = <String, dynamic>{}.obs;
  static RxMap<String, dynamic> userRoles = <String, dynamic>{}.obs;
  static RxMap<String, dynamic> registerBody = <String, dynamic>{}.obs;

  static RxString deviceSerial = ''.obs;
  static RxString otpRefID = ''.obs;
  static RxString token = ''.obs;
  static RxString userTextInput = ''.obs;
  static RxString version = ''.obs;

  static late Rx<UserAccountModel> userAccountModel;
}
