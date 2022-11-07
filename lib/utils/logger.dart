import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

logger(response, {Map? body}) {
  if (kDebugMode) {
    try {
      Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false)).d(
        '${response.request} : STATUS ${response.statusCode}${body != null ? '\nBody : ${const JsonEncoder.withIndent('  ').convert(body)}' : ''}\n${const JsonEncoder.withIndent('  ').convert(jsonDecode(response.body))}',
      );
    } on FormatException catch (_) {
      Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false)).d(
        '${response.request} : STATUS ${response.statusCode}${body != null ? '\nBody : $body' : ''}\n${response.body}',
      );
    }
  }
}
