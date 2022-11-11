import 'package:tms/state_management.dart';

String hostDev = "https://139.59.119.249:6480/";

String errorTimeout = 'หมดเวลาการเชื่อมต่อ';
String messageOffline = 'ขาดการเชื่อมต่ออินเทอร์เน็ต';
String errorNotFound = 'กรุณาลองใหม่อีกครั้ง';

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
