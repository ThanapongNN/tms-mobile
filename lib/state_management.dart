import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tms/models/user_account.model.dart';

//ตัวแปรกองกลาง
class Store {
  static RxBool drawer = false.obs;

  static RxInt currentIndex = 0.obs;

  static RxMap<String, dynamic> partnerTypes = <String, dynamic>{
    "code": "200",
    "description": "SUCCESS",
    "partnerTypes": [
      {
        "code": "71100028",
        "name": {"th": "7-Eleven 00028", "en": "7-Eleven 00028"},
        "dmsAppChannel": "",
      },
      {
        "code": "Lotus HDE",
        "name": {"th": "Lotus HDE", "en": "Lotus HDE"},
        "dmsAppChannel": "",
      },
      {
        "code": "Lotus Go Fresh",
        "name": {"th": "Lotus Go Fresh", "en": "Lotus Go Fresh"},
        "dmsAppChannel": "",
      },
      {
        "code": "Lotus Talad",
        "name": {"th": "Lotus Talad", "en": "Lotus Talad"},
        "dmsAppChannel": "",
      },
    ]
  }.obs;
  static RxMap<String, dynamic> userAccount = <String, dynamic>{}.obs;
  static RxMap<String, dynamic> userRoles = <String, dynamic>{
    "code": "200",
    "description": "SUCCESS",
    "userRoles": [
      {
        "code": "1",
        "name": {"th": "ผู้จัดการสาขา", "en": "ผู้จัดการสาขา"}
      },
      {
        "code": "1",
        "name": {"th": "พนักงานประจำสาขา", "en": "พนักงานประจำสาขา"}
      }
    ]
  }.obs;
  static RxMap<String, dynamic> registerBody = <String, dynamic>{}.obs;

  static RxString deviceSerial = ''.obs;
  static RxString saleID = ''.obs;
  static RxString otpRefID = ''.obs;
  static RxString token = ''.obs;
  static RxString userTextInput = ''.obs;
  static RxString version = ''.obs;

  static late Rx<UserAccountModel> userAccountModel;
}
