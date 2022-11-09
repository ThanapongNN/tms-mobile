import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextInputFormatter {
  static MaskTextInputFormatter maskTextIDCardTH = MaskTextInputFormatter(
    mask: '#-####-#####-##-#',
    filter: {"#": RegExp(r'[0-9]')},
  );

  static MaskTextInputFormatter maskTextLaserIDCardTH = MaskTextInputFormatter(
    mask: '###-#######-##',
    filter: {"#": RegExp(r'[a-zA-Z0-9]')},
  );

  static MaskTextInputFormatter maskTextPhoneNumber = MaskTextInputFormatter(
    mask: '###-###-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  static FilteringTextInputFormatter filterInputNumber = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  static FilteringTextInputFormatter filterInputENxNumber = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));

  static FilteringTextInputFormatter filterInputTH = FilteringTextInputFormatter.allow(RegExp(r'[ก-๙]'));

  static maskTextAmount({required String? number, int decimalDigits = 2}) {
    number = number ?? '0';
    return NumberFormat.simpleCurrency(name: '', decimalDigits: decimalDigits).format(double.parse(number.replaceAll(',', '')));
  }
}
