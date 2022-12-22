import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/state_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/models/learning.model.dart';
import 'package:tms/models/news.model.dart';
import 'package:tms/models/user_account.model.dart';
import 'package:tms/state_management.dart';

Future<bool> firstLoginRequest(String employeeId) async {
  await EasyLoading.show();

  List<CallBack> call = await Future.wait([
    Call.raw(
      method: Method.get,
      url: '$host/user/v1/accounts/$employeeId',
      headers: Authorization.token,
      showDialog: false,
      showLoading: false,
    ),
    Call.raw(
      method: Method.get,
      url: '$host/product-group/v1/productGroup/$employeeId',
      headers: Authorization.token,
      showDialog: false,
      showLoading: false,
    ),
    Call.raw(
      method: Method.get,
      url: '$host/news-campaign/v1/news-campaign',
      headers: Authorization.token,
      showDialog: false,
      showLoading: false,
    ),
    Call.raw(
      method: Method.get,
      url: '$host/learning-course/v1/learning-course',
      headers: Authorization.token,
      showDialog: false,
      showLoading: false,
    ),
  ]);

  if (call[0].success) Store.userAccountModel = UserAccountModel.fromJson(call[0].response).obs;
  if (call[1].success) Store.productGroup.value = call[1].response;
  if (call[2].success) Store.newsModel = NewsModel.fromJson(call[2].response).obs;
  if (call[3].success) Store.learningModel = LearningModel.fromJson(call[3].response).obs;

  await EasyLoading.dismiss();

  return call.every((e) => e.success);
}
