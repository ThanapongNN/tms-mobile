import 'package:get/state_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/models/user_roles.model.dart';
import 'package:tms/state_management.dart';

Future<bool> createAccountRequest() async {
  List<bool> isSuccess = [];

  await Future.wait([
    (Store.partnerTypes.isEmpty)
        ? Call.raw(method: Method.get, url: '$host/content/v1/partner-types').then((partnerType) {
            isSuccess.add(partnerType.success);
            if (partnerType.success) Store.partnerTypes.value = partnerType.response;
          })
        : Future.delayed(const Duration(seconds: 0)),
    (Store.userRolesModel == null)
        ? Call.raw(method: Method.get, url: '$host/content/v1/user-roles').then((userRoles) {
            isSuccess.add(userRoles.success);

            if (userRoles.success) Store.userRolesModel = UserRolesModel.fromJson(userRoles.response).obs;
          })
        : Future.delayed(const Duration(seconds: 0)),
  ]);

  return isSuccess.every((element) => element);
}
