import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

logger(response, {Object? body}) {
  if (kDebugMode) {
    try {
      Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false)).d(
        '${response.request} : STATUS ${response.statusCode}${body != null ? '\nBody : ${const JsonEncoder.withIndent('  ').convert(body)}' : ''}\nResponse : ${const JsonEncoder.withIndent('  ').convert(jsonDecode(response.body))}',
      );
    } on FormatException catch (_) {
      Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false)).d(
        '${response.request} : STATUS ${response.statusCode}${body != null ? '\nBody : $body' : ''}\nResponse : ${response.body}',
      );
    }
  }
}
