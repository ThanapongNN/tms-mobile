import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/state_management.dart';

Future<bool> createAccountRequest() async {
  List<bool> isSuccess = [];

  if (Store.partnerTypes.isEmpty) {
    CallBack data = await Call.raw(
      method: Method.get,
      url: '$hostTrue/content/v1/partner-types',
    );

    isSuccess.add(data.success);
    if (data.success) Store.partnerTypes.value = data.response;
  }

  if (Store.userRoles.isEmpty) {
    CallBack data = await Call.raw(
      method: Method.get,
      url: '$hostTrue/content/v1/user-roles',
    );

    isSuccess.add(data.success);
    if (data.success) Store.userRoles.value = data.response;
  }

  return isSuccess.every((element) => element);
}
