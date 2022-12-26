import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:tms/state_management.dart';

class GALog {
  static content(String content) {
    List<String> listRoleCode = Store.userRolesModel!.value.userRoles.map((e) => e.code).toList();
    String role = Store.userRolesModel!.value.userRoles[listRoleCode.indexOf(Store.userAccountModel!.value.account.employee.roleCode)].name.th;

    FirebaseAnalytics.instance.logEvent(
      name: 'select_content',
      parameters: <String, dynamic>{
        "user_id": Store.userAccountModel!.value.account.employee.empId,
        "partner_code": Store.userAccountModel!.value.account.partnerCode,
        "partner_name": Store.userAccountModel!.value.account.partnerName,
        "user_name": "${Store.userAccountModel!.value.account.employee.name} ${Store.userAccountModel!.value.account.employee.surname}",
        "create_at": Store.userAccountModel!.value.account.createAt.toString(),
        "role": role,
        "date_time": "${DateTime.now()}",
        "content": content,
      },
    );
  }
}
