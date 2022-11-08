bool validatePassword(String value) {
  // String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'; //อย่างน้อย 1 ตัว พิมพ์ใหญ่ พิมพ์เล็ก ตัวเลข อักขระพิเศษ รวม 8 หลัก
  String pattern = r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{8,}$'; //ตัวอักษรและตัวเลขอย่างน้อย 1 ตัว รวม 8 หลัก
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}
