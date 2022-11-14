import 'package:tms/state_management.dart';

String hostDev = "http://139.59.119.249:4500";

String errorTimeout = 'หมดเวลาเชื่อมต่อ กรุณาลองใหม่อีกครั้ง';
String messageOffline = 'ขาดการเชื่อมต่อ กรุณาลองใหม่อีกครั้ง';
String errorNotFound = 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง';

enum Authorization { token, none }

Map<String, String> setHeaders(Authorization headers) {
  switch (headers) {
    case Authorization.token:
      return {"Authorization": "Bearer ${Store.token.value}"};
    default:
      return {};
  }
}

class CallBack {
  CallBack({required this.success, required this.response});

  bool success;
  dynamic response;
}
