import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/state_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/models/learning.model.dart';
import 'package:tms/models/news.model.dart';
import 'package:tms/models/user_account.model.dart';
import 'package:tms/models/user_roles.model.dart';
import 'package:tms/state_management.dart';

Future<void> firstLoginRequest({bool showLoading = true}) async {
  if (showLoading) EasyLoading.show();

  await Future.wait([
    (Store.userRolesModel == null)
        ? Call.raw(
            method: Method.get,
            url: '$host/content/v1/user-roles',
            showLoading: false,
            showDialog: false,
          ).then((userRoles) {
            if (userRoles.success) Store.userRolesModel = UserRolesModel.fromJson(userRoles.response).obs;
          })
        : Future.delayed(const Duration(seconds: 0)),
    (Store.userAccountModel == null)
        ? Call.raw(
            method: Method.get,
            url: '$host/user/v1/accounts/${Store.encryptedEmployeeId.value}',
            headers: Authorization.token,
            showDialog: false,
            showLoading: false,
          ).then((userAccount) {
            if (userAccount.success) Store.userAccountModel = UserAccountModel.fromJson(userAccount.response).obs;
          })
        : Future.delayed(const Duration(seconds: 0)),
    (Store.productGroup.isEmpty)
        ? Call.raw(
            method: Method.get,
            url: '$host/product-group/v1/productGroup/${Store.encryptedEmployeeId.value}',
            headers: Authorization.token,
            showDialog: false,
            showLoading: false,
          ).then((productGroup) {
            if (productGroup.success) Store.productGroup.value = productGroup.response;
          })
        : Future.delayed(const Duration(seconds: 0)),
    (Store.newsModel == null)
        ? Call.raw(
            method: Method.get,
            url: '$host/news-campaign/v1/news-campaign',
            headers: Authorization.token,
            showDialog: false,
            showLoading: false,
          ).then((newsCampaign) {
            if (newsCampaign.success) Store.newsModel = NewsModel.fromJson(newsCampaign.response).obs;
          })
        : Future.delayed(const Duration(seconds: 0)),
    (Store.learningModel == null)
        ? Call.raw(
            method: Method.get,
            url: '$host/learning-course/v1/learning-course',
            headers: Authorization.token,
            showDialog: false,
            showLoading: false,
          ).then((learning) {
            if (learning.success) Store.learningModel = LearningModel.fromJson(learning.response).obs;
          })
        : Future.delayed(const Duration(seconds: 0)),
  ]);

  if (showLoading) EasyLoading.dismiss();
}
