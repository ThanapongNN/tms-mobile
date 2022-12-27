import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:tms/state_management.dart';

class GALog {
  static content(String content) {
    FirebaseAnalytics.instance.logEvent(
      name: 'select_content',
      parameters: <String, dynamic>{
        "user_id": Store.userAccountModel!.value.account.employee.empId,
        "partner_code": Store.userAccountModel!.value.account.partnerCode,
        "partner_name": Store.userAccountModel!.value.account.partnerName,
        "user_name": "${Store.userAccountModel!.value.account.employee.name} ${Store.userAccountModel!.value.account.employee.surname}",
        "create_at": Store.userAccountModel!.value.account.createAt.toString(),
        "role": Store.userAccountModel!.value.account.employee.roleName.nameTh,
        "date_time": "${DateTime.now()}",
        "content": content,
      },
    );
  }
}
