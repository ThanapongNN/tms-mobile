import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tms/models/forgot_password.model.dart';
import 'package:tms/models/user_account.model.dart';

//ตัวแปรกองกลาง
class Store {
  static RxBool drawer = false.obs;

  static RxInt currentIndex = 0.obs;
  static RxInt indexProductGroup = 0.obs;

  static RxMap<String, dynamic> partnerTypes = <String, dynamic>{}.obs;
  static RxMap<String, dynamic> userAccount = <String, dynamic>{}.obs;
  static RxMap<String, dynamic> userRoles = <String, dynamic>{}.obs;
  static RxMap<String, dynamic> registerBody = <String, dynamic>{}.obs;

  static RxMap<String, dynamic> productGroup = <String, dynamic>{
    "code": "200",
    "description": "SUCCESS",
    "lastUpdate": "2022-11-23T09:19:55",
    "productGroup": [
      {
        "code": "1",
        "product": "ยอดขายมือถือ",
        "salesTotal": "5",
        "salesOrder": [
          {
            "order": "ยอดขายมือถือ",
            "orderTotal": "5",
            "unit": "เครื่อง",
            "serviceCampaign": [
              {"name": "OPPO A74", "ea": "2", "unit": "เครื่อง"},
              {"name": "True A5G", "ea": "1", "unit": "เครื่อง"},
              {"name": "OPPO A165", "ea": "1", "unit": "เครื่อง"},
              {"name": "Wikko Y82", "ea": "1", "unit": "เครื่อง"}
            ]
          }
        ],
      },
      {
        "code": "2",
        "product": "ยอดขายเบอร์",
        "salesTotal": "105",
        "salesOrder": [
          {
            "order": "ซิม 7-11",
            "orderTotal": "25",
            "unit": "เบอร์",
            "serviceCampaign": [
              {"name": "ซิมที่มีการเติมเงินเติมเน็ต", "ea": "20", "unit": "เบอร์"},
              {"name": "ซิมที่ไม่มีการเติมแพ็ค", "ea": "5", "unit": "เบอร์"}
            ]
          },
          {
            "order": "ซิมเติมเงิน",
            "orderTotal": "22",
            "unit": "เบอร์",
            "serviceCampaign": [
              {"name": "ซิมเติมเงินพร้อมเครื่อง", "ea": "12", "unit": "เบอร์"},
              {"name": "ซิมฟันธง", "ea": "3", "unit": "เบอร์"},
              {"name": "ซิมย้ายค่าย", "ea": "2", "unit": "เบอร์"},
              {"name": "ซิมเติมเงินอื่นๆ", "ea": "5", "unit": "เบอร์"}
            ]
          },
          {
            "order": "ซิมรายเดือน",
            "orderTotal": "28",
            "unit": "เบอร์",
            "serviceCampaign": [
              {"name": "ซิมรายเดือนพร้อมเครื่อง", "ea": "13", "unit": "เบอร์"},
              {"name": "ซิมฟันธง", "ea": "6", "unit": "เบอร์"},
              {"name": "ซิมสวยเลือกได้", "ea": "5", "unit": "เบอร์"},
              {"name": "ซิมย้ายค่าย", "ea": "3", "unit": "เบอร์"},
              {"name": "ซิมเบอร์มงคล", "ea": "1", "unit": "เบอร์"}
            ]
          },
          {
            "order": "ย้ายค่ายเบอร์เดิม",
            "orderTotal": "15",
            "unit": "เบอร์",
            "serviceCampaign": [
              {"name": "ย้ายค่ายเติมเงิน", "ea": "8", "unit": "เบอร์"},
              {"name": "ย้ายค่ายรายเดือน", "ea": "5", "unit": "เบอร์"},
              {"name": "ย้ายค่ายรายเดือนพร้อมเครื่อง", "ea": "2", "unit": "เบอร์"}
            ]
          },
          {
            "order": "เปลี่ยนเติมเงินเป็นรายเดือน",
            "orderTotal": "15",
            "unit": "เบอร์",
            "serviceCampaign": [
              {"name": "ซิม", "ea": "6", "unit": "เบอร์"},
              {"name": "ซิมพร้อมเครื่อง", "ea": "9", "unit": "เบอร์"}
            ]
          }
        ],
      },
      {
        "code": "3",
        "product": "ยอดสมัครเน็ตบ้านและทีวี",
        "salesTotal": "19",
        "salesOrder": [
          {
            "order": "ยอดสมัครเน็ตบ้าน/ทีวี",
            "orderTotal": "19",
            "unit": "เบอร์",
            "serviceCampaign": [
              {"name": "การสมัครด้วยตัวเอง", "ea": "17", "unit": "เบอร์"},
              {"name": "การส่งรายชื่อลูกค้า", "ea": "2", "unit": "เบอร์"}
            ]
          }
        ],
      },
      {
        "code": "4",
        "product": "ยอดขายเติมเงินเติมเน็ต",
        "salesTotal": "12",
        "salesOrder": [
          {
            "order": "ยอดเติมเงิน",
            "orderTotal": "6",
            "unit": "เบอร์",
            "serviceCampaign": [
              {"name": "แพ็ค XX", "ea": "2", "unit": "เบอร์"},
              {"name": "แพ็ค XXXX", "ea": "2", "unit": "เบอร์"},
              {"name": "แพ็คอื่นๆ", "ea": "2", "unit": "เบอร์"}
            ]
          },
          {
            "order": "ยอดเติมเน็ต",
            "orderTotal": "6",
            "unit": "เบอร์",
            "serviceCampaign": [
              {"name": "แพ็ค XX", "ea": "2", "unit": "เบอร์"},
              {"name": "แพ็ค XXXX", "ea": "2", "unit": "เบอร์"},
              {"name": "แพ็คอื่นๆ", "ea": "2", "unit": "เบอร์"}
            ]
          }
        ],
      }
    ]
  }.obs;

  static RxMap<String, dynamic> allProductGroup = <String, dynamic>{
    "allProductGroup": [
      {
        "icon": "assets/images/phone_with_sim.svg",
        "order": "ยอดขายมือถือ",
        "orderTotal": "5",
        "unit": "เครื่อง",
        "serviceCampaign": [
          {"name": "OPPO A74", "ea": "2", "unit": "เครื่อง"},
          {"name": "True A5G", "ea": "1", "unit": "เครื่อง"},
          {"name": "OPPO A165", "ea": "1", "unit": "เครื่อง"},
          {"name": "Wikko Y82", "ea": "1", "unit": "เครื่อง"}
        ]
      },
      {
        "icon": "assets/images/sim.svg",
        "order": "ซิม 7-11",
        "orderTotal": "25",
        "unit": "เบอร์",
        "serviceCampaign": [
          {"name": "ซิมที่มีการเติมเงินเติมเน็ต", "ea": "20", "unit": "เบอร์"},
          {"name": "ซิมที่ไม่มีการเติมแพ็ค", "ea": "5", "unit": "เบอร์"}
        ]
      },
      {
        "icon": "assets/images/sim.svg",
        "order": "ซิมเติมเงิน",
        "orderTotal": "22",
        "unit": "เบอร์",
        "serviceCampaign": [
          {"name": "ซิมเติมเงินพร้อมเครื่อง", "ea": "12", "unit": "เบอร์"},
          {"name": "ซิมฟันธง", "ea": "3", "unit": "เบอร์"},
          {"name": "ซิมย้ายค่าย", "ea": "2", "unit": "เบอร์"},
          {"name": "ซิมเติมเงินอื่นๆ", "ea": "5", "unit": "เบอร์"}
        ]
      },
      {
        "icon": "assets/images/sim.svg",
        "order": "ซิมรายเดือน",
        "orderTotal": "28",
        "unit": "เบอร์",
        "serviceCampaign": [
          {"name": "ซิมรายเดือนพร้อมเครื่อง", "ea": "13", "unit": "เบอร์"},
          {"name": "ซิมฟันธง", "ea": "6", "unit": "เบอร์"},
          {"name": "ซิมสวยเลือกได้", "ea": "5", "unit": "เบอร์"},
          {"name": "ซิมย้ายค่าย", "ea": "3", "unit": "เบอร์"},
          {"name": "ซิมเบอร์มงคล", "ea": "1", "unit": "เบอร์"}
        ]
      },
    ]
  }.obs;

  static RxString deviceSerial = ''.obs;
  static RxString saleID = ''.obs;
  static RxString selectedProductGroup = ''.obs;
  static RxString otpRefID = ''.obs;
  static RxString token = ''.obs;
  static RxString userTextInput = ''.obs;
  static RxString version = ''.obs;

  static late Rx<ForgotPasswordModel> forgotPasswordModel;
  static late Rx<UserAccountModel> userAccountModel;
}
