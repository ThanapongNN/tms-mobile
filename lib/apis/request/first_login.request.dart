import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/state_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/models/learning.model.dart';
import 'package:tms/models/news.model.dart';
import 'package:tms/models/user_account.model.dart';
import 'package:tms/state_management.dart';

Future<void> firstLoginRequest(String employeeId, {bool showLoading = true}) async {
  if (showLoading) await EasyLoading.show();

  await Future.wait([
    (Store.userAccountModel == null)
        ? Call.raw(
            method: Method.get,
            url: '$host/user/v1/accounts/$employeeId',
            headers: Authorization.token,
            showDialog: false,
            showLoading: false,
          ).then((userAccount) {
            if (userAccount.success) {
              Store.userAccountModel = UserAccountModel.fromJson(userAccount.response).obs;
              FirebaseAnalytics.instance.logEvent(
                name: 'login',
                parameters: <String, dynamic>{
                  "emp_id": Store.userAccountModel!.value.account.employee.empId,
                  "partner_code": Store.userAccountModel!.value.account.partnerCode,
                  "partner_name": Store.userAccountModel!.value.account.partnerName,
                  "name_surname": "${Store.userAccountModel!.value.account.employee.name} ${Store.userAccountModel!.value.account.employee.surname}",
                  "create_at": Store.userAccountModel!.value.account.createAt.toString(),
                  "role_code": Store.userAccountModel!.value.account.employee.roleCode,
                  "status": Store.userAccountModel!.value.account.status,
                },
              );
            }
          })
        : Future.delayed(const Duration(seconds: 0)),
    (Store.productGroup.isEmpty)
        ? Call.raw(
            method: Method.get,
            url: '$host/product-group/v1/productGroup/$employeeId',
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

  if (showLoading) await EasyLoading.dismiss();
}
