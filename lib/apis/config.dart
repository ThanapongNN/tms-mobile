import 'package:tms/state_management.dart';

// String hostDev = "http://139.59.119.249:4500";
String hostTrue = "https://f60e-171-96-155-216.ap.ngrok.io";

String errorTimeout = 'หมดเวลาเชื่อมต่อ กรุณาลองใหม่อีกครั้ง';
String messageOffline = 'ขาดการเชื่อมต่อ กรุณาลองใหม่อีกครั้ง';
String errorNotFound = 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง';

enum Authorization { token, none, textPlain }

Map<String, String> setHeaders(Authorization headers) {
  switch (headers) {
    case Authorization.token:
      return {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${Store.token.value}'};
    case Authorization.textPlain:
      return {};
    default:
      return {'Content-Type': 'application/json; charset=UTF-8'};
  }
}

class CallBack {
  CallBack({required this.success, required this.response});

  bool success;
  dynamic response;
}

class ErrorMessage {
  ErrorMessage({
    required this.errorMessage, //ข้อความที่ต้องการเอามาเปรียบเทียบ
    this.titleDialog, //หัวข้อที่ต้องการเปลี่ยนแทน
    this.contentDialog, //เนื้อหาที่ต้องการเปลี่ยนแทน
  });

  String errorMessage;
  String? titleDialog, contentDialog;
}
