import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/state_management.dart';
import 'package:tms/utils/logger.dart';
import 'package:tms/widgets/dialog.dart';
import 'package:http/http.dart' as http;

class API {
  //POST raw
  static Future<CallBack> post({
    required String url,
    required Authorization headers,
    required Object? body,
    bool showDialog = true,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) EasyLoading.show();
      final response = await http.post(Uri.parse(url), headers: setHeaders(headers), body: jsonEncode(body)).timeout(const Duration(seconds: 30));
      if (showLoading) EasyLoading.dismiss();

      logger(response, body: body);

      if (response.statusCode == 200) {
        return CallBack(success: true, response: jsonDecode(response.body));
      } else {
        Map dataError = jsonDecode(response.body);
        String errorMessage = dataError["description"] ?? errorNotFound;
        dialog(content: errorMessage, showDialog: showDialog);
        return CallBack(success: false, response: dataError);
      }
    } on TimeoutException catch (_) {
      dialog(content: errorTimeout);
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: errorTimeout);
    } on SocketException catch (_) {
      dialog(content: messageOffline);
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: messageOffline);
    } catch (error) {
      dialog(content: error.toString());
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: error);
    }
  }

  //POST form-data
  static Future<CallBack> postFormData({
    required String url,
    required List<MultipartFile> files,
    bool showDialog = true,
  }) async {
    EasyLoading.show();
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers['authorization'] = "Bearer ${Store.token.value}";

    for (var e in files) {
      request.files.add(e);
    }

    try {
      final response = await request.send().timeout(const Duration(seconds: 30));
      String resStr = await response.stream.bytesToString();
      EasyLoading.dismiss();
      Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false)).d(
        '${response.request} : STATUS ${response.statusCode}\n$resStr',
      );

      if (response.statusCode == 200) {
        return CallBack(success: true, response: jsonDecode(resStr));
      } else {
        Map dataError = jsonDecode(resStr)[0];
        String errorMessage = dataError["description"] ?? errorNotFound;
        dialog(content: errorMessage, showDialog: showDialog);
        return CallBack(success: false, response: dataError);
      }
    } on TimeoutException catch (_) {
      dialog(content: errorTimeout);
      EasyLoading.dismiss();
      return CallBack(success: false, response: errorTimeout);
    } on SocketException catch (_) {
      dialog(content: messageOffline);
      EasyLoading.dismiss();
      return CallBack(success: false, response: messageOffline);
    } on FormatException catch (_) {
      EasyLoading.dismiss();
      return CallBack(success: true, response: errorNotFound);
    } catch (error) {
      dialog(content: error.toString());
      EasyLoading.dismiss();
      return CallBack(success: false, response: error);
    }
  }

  //GET
  static Future<CallBack> get({
    required String url,
    required Authorization headers,
    bool showDialog = true,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) EasyLoading.show();
      final response = await http.get(Uri.parse(url), headers: setHeaders(headers)).timeout(const Duration(seconds: 30));
      if (showLoading) EasyLoading.dismiss();

      logger(response);

      if (response.statusCode == 200) {
        return CallBack(success: true, response: jsonDecode(response.body));
      } else {
        Map dataError = jsonDecode(response.body);
        String errorMessage = dataError["description"] ?? errorNotFound;
        dialog(content: errorMessage, showDialog: showDialog);
        return CallBack(success: false, response: dataError);
      }
    } on TimeoutException catch (_) {
      dialog(content: errorTimeout);
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: errorTimeout);
    } on SocketException catch (_) {
      dialog(content: messageOffline);
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: messageOffline);
    } catch (error) {
      dialog(content: error.toString());
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: error);
    }
  }

  //PUT raw
  static Future<CallBack> put({
    required String url,
    required Authorization headers,
    required Object? body,
    bool showDialog = true,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) EasyLoading.show();
      final response = await http.put(Uri.parse(url), headers: setHeaders(headers), body: body).timeout(const Duration(seconds: 30));
      if (showLoading) EasyLoading.dismiss();

      logger(response, body: body);

      if (response.statusCode == 200) {
        return CallBack(success: true, response: jsonDecode(response.body));
      } else {
        Map dataError = jsonDecode(response.body);
        String errorMessage = dataError["description"] ?? errorNotFound;
        dialog(content: errorMessage, showDialog: showDialog);
        return CallBack(success: false, response: dataError);
      }
    } on TimeoutException catch (_) {
      dialog(content: errorTimeout);
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: errorTimeout);
    } on SocketException catch (_) {
      dialog(content: messageOffline);
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: messageOffline);
    } catch (error) {
      dialog(content: error.toString());
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: error);
    }
  }

  //PATCH raw
  static Future<CallBack> patch({
    required String url,
    required Authorization headers,
    required Object? body,
    bool showDialog = true,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) EasyLoading.show();
      final response = await http.patch(Uri.parse(url), headers: setHeaders(headers), body: body).timeout(const Duration(seconds: 30));
      if (showLoading) EasyLoading.dismiss();

      logger(response, body: body);

      if (response.statusCode == 200) {
        return CallBack(success: true, response: jsonDecode(response.body));
      } else {
        Map dataError = jsonDecode(response.body);
        String errorMessage = dataError["description"] ?? errorNotFound;
        dialog(content: errorMessage, showDialog: showDialog);
        return CallBack(success: false, response: dataError);
      }
    } on TimeoutException catch (_) {
      dialog(content: errorTimeout);
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: errorTimeout);
    } on SocketException catch (_) {
      dialog(content: messageOffline);
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: messageOffline);
    } catch (error) {
      dialog(content: error.toString());
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: error);
    }
  }

  //DELETE raw
  static Future<CallBack> delete({
    required String url,
    required Authorization headers,
    required Object? body,
    bool showDialog = true,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) EasyLoading.show();
      final response = await http.delete(Uri.parse(url), headers: setHeaders(headers), body: body).timeout(const Duration(seconds: 30));
      if (showLoading) EasyLoading.dismiss();

      logger(response, body: body);

      if (response.statusCode == 200) {
        return CallBack(success: true, response: jsonDecode(response.body));
      } else {
        Map dataError = jsonDecode(response.body);
        String errorMessage = dataError["description"] ?? errorNotFound;
        dialog(content: errorMessage, showDialog: showDialog);
        return CallBack(success: false, response: dataError);
      }
    } on TimeoutException catch (_) {
      dialog(content: errorTimeout);
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: errorTimeout);
    } on SocketException catch (_) {
      dialog(content: messageOffline);
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: messageOffline);
    } catch (error) {
      dialog(content: error.toString());
      return CallBack(success: false, response: error);
    }
  }
}
