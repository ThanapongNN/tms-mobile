import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

//จัดฟอแมตของข้อความให้ตรงตามรูปแบบที่กำหนด
class MaskTextFormatter {
  static MaskTextInputFormatter numberIDCardTH = MaskTextInputFormatter(
    mask: '#-####-#####-##-#',
    filter: {"#": RegExp(r'[0-9]')},
  );

  static MaskTextInputFormatter laserIDCardTH = MaskTextInputFormatter(
    mask: '###-#######-##',
    filter: {"#": RegExp(r'[a-zA-Z0-9]')},
  );

  static MaskTextInputFormatter phoneNumber = MaskTextInputFormatter(
    mask: '###-###-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  static amount({required String? number, int decimalDigits = 2}) {
    number = number ?? '0';
    return NumberFormat.simpleCurrency(name: '', decimalDigits: decimalDigits).format(double.parse(number.replaceAll(',', '')));
  }
}
