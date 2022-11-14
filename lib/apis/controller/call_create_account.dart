import 'package:tms/apis/api.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/models/partner_types.dart';
import 'package:tms/models/user_roles.dart';
import 'package:tms/state_management.dart';

Future<void> callCreateAccount() async {
  if (Store.partnerTypes.isEmpty) {
    CallBack data = await API.get(url: '$hostDev/content/v1/partner-types', headers: Authorization.none);
    if (data.success) {
      PartnerTypes partnerTypes = PartnerTypes.fromJson(data.response);
      for (var e in partnerTypes.partnerTypes) {
        Store.partnerTypes.add(e.name.th);
      }
    }
  }

  if (Store.userRoles.isEmpty) {
    CallBack data = await API.get(url: '$hostDev/content/v1/user-roles', headers: Authorization.none);
    if (data.success) {
      UserRoles userRoles = UserRoles.fromJson(data.response);
      for (var e in userRoles.userRoles) {
        Store.userRoles.add(e.name.th);
      }
    }
  }
}
