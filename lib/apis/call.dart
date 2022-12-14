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

class Call {
  //Call raw
  static Future<CallBack> raw({
    required Method method,
    required String url,
    Authorization headers = Authorization.none,
    Object? body,
    bool showDialog = true,
    bool showLoading = true,
    String? errorMessage,
    List<ErrorMessage>? compareError,
  }) async {
    try {
      Response response;
      if (showLoading) EasyLoading.show();

      switch (method) {
        case Method.post:
          response = await http.post(Uri.parse(url), headers: setHeaders(headers), body: jsonEncode(body)).timeout(const Duration(seconds: 30));
          break;
        case Method.get:
          response = await http.get(Uri.parse(url), headers: setHeaders(headers)).timeout(const Duration(seconds: 30));
          break;
        case Method.put:
          response = await http.put(Uri.parse(url), headers: setHeaders(headers), body: body).timeout(const Duration(seconds: 30));
          break;
        case Method.patch:
          response = await http.patch(Uri.parse(url), headers: setHeaders(headers), body: body).timeout(const Duration(seconds: 30));
          break;
        case Method.delete:
          response = await http.delete(Uri.parse(url), headers: setHeaders(headers), body: body).timeout(const Duration(seconds: 30));
          break;
        default:
          return CallBack(success: false, response: errorNotFound);
      }
      if (showLoading) EasyLoading.dismiss();

      logger(response, body: body);

      if (response.statusCode == 200) {
        return CallBack(success: true, response: jsonDecode(response.body));
      } else {
        Map dataError = jsonDecode(response.body);
        errorMessage = errorMessage ?? dataError["description"] ?? errorNotFound;

        if (compareError != null) {
          for (var message in compareError) {
            if (errorMessage == message.errorMessage) {
              errorMessage = message.contentDialog;
              break;
            }
          }
        }

        dialog(content: errorMessage!, showDialog: showDialog);
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
      dialog(content: errorNotFound);
      if (showLoading) EasyLoading.dismiss();
      return CallBack(success: false, response: errorNotFound);
    }
  }

  //Call form-data
  static Future<CallBack> formData({
    required String url,
    required List<MultipartFile> files,
    bool showDialog = true,
    String? errorMessage,
  }) async {
    EasyLoading.show();
    MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));

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
        errorMessage = errorMessage ?? dataError["description"] ?? errorNotFound;
        dialog(content: errorMessage!, showDialog: showDialog);
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
    } catch (error) {
      dialog(content: errorNotFound);
      EasyLoading.dismiss();
      return CallBack(success: false, response: errorNotFound);
    }
  }
}

enum Method { post, get, put, patch, delete }
