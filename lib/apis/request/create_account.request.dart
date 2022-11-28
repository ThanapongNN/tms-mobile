import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/state_management.dart';

Future<bool> callCreateAccount() async {
  List<bool> isSuccess = [];

  if (Store.partnerTypes.isEmpty) {
    CallBack data = await Call.raw(
      method: Method.get,
      url: '$hostTrue/content/v1/partner-types',
    );
    if (data.success) {
      isSuccess.add(true);
      Store.partnerTypes.value = data.response;
    } else {
      isSuccess.add(false);
    }
  }

  if (Store.userRoles.isEmpty) {
    CallBack data = await Call.raw(
      method: Method.get,
      url: '$hostTrue/content/v1/user-roles',
    );
    if (data.success) {
      isSuccess.add(true);
      Store.userRoles.value = data.response;
    } else {
      isSuccess.add(false);
    }
  }

  return isSuccess.every((element) => element);
}
