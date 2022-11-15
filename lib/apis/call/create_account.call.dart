import 'package:tms/apis/api.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/state_management.dart';

Future<void> callCreateAccount() async {
  if (Store.partnerTypes.isEmpty) {
    CallBack data = await API.call(method: Method.get, url: '$hostDev/content/v1/partner-types', headers: Authorization.none);
    if (data.success) {
      Store.partnerTypes.value = data.response;
    }
  }

  if (Store.userRoles.isEmpty) {
    CallBack data = await API.call(method: Method.get, url: '$hostDev/content/v1/user-roles', headers: Authorization.none);
    if (data.success) {
      Store.userRoles.value = data.response;
    }
  }
}
