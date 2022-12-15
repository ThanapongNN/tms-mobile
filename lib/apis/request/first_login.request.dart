import 'package:get/state_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/models/learning.model.dart';
import 'package:tms/models/news.model.dart';
import 'package:tms/models/product_group.model.dart';
import 'package:tms/models/user_account.model.dart';
import 'package:tms/state_management.dart';

Future<void> firstLoginRequest(String employeeId) async {
  await Future.wait([
    Call.raw(
      method: Method.get,
      url: '$host/user/v1/accounts/$employeeId',
      headers: Authorization.token,
      showDialog: false,
    ).then((userAccount) {
      if (userAccount.success) Store.userAccountModel = UserAccountModel.fromJson(userAccount.response).obs;
    }),
    Call.raw(
      method: Method.get,
      url: '$host/product-group/v1/productGroup/$employeeId',
      headers: Authorization.token,
      showDialog: false,
    ).then((productGroup) {
      if (productGroup.success) Store.productGroupModel = ProductGroupModel.fromJson(productGroup.response).obs;
    }),
    Call.raw(
      method: Method.get,
      url: '$host/news-campaign/v1/news-campaign',
      headers: Authorization.token,
      showDialog: false,
    ).then((newsCampaign) {
      if (newsCampaign.success) Store.newsModel = NewsModel.fromJson(newsCampaign.response).obs;
    }),
    Call.raw(
      method: Method.get,
      url: '$host/learning-course/v1/learning-course',
      headers: Authorization.token,
      showDialog: false,
    ).then((learning) {
      if (learning.success) Store.learningModel = LearningModel.fromJson(learning.response).obs;
    })
  ]);
}
