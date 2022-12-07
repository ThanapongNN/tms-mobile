import 'package:get/state_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/models/product_group.model.dart';
import 'package:tms/models/user_account.model.dart';
import 'package:tms/state_management.dart';

Future callAccountProductGroup(String employeeId) async {
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
    })
  ]);
}
