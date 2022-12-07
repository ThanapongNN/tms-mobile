import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/widgets/dialog.dart';

Future<bool> validateAccountRequest({required String saleID, required String msisdn, required thaiID}) async {
  List<bool> isSuccess = [];

  CallBack checkSaleID = await Call.raw(
    method: Method.get,
    url: '$host/user/v1/check/$saleID',
  );

  CallBack checkTrueMove = await Call.raw(
    method: Method.post,
    url: '$host/support/v1/truemobile/validation',
    body: {"msisdn": msisdn},
  );

  if (!checkTrueMove.response['result']) dialog(content: 'กรุณาระบุเบอร์โทรศัพท์มือถือทรูมูฟเอชเท่านั้น');

  CallBack checkThaiID = await Call.raw(
    method: Method.get,
    url: '$host/user/v1/check/thai_id/$thaiID',
  );

  if (!checkThaiID.response['result']) dialog(content: checkThaiID.response["description"]);

  isSuccess.add(checkSaleID.success);
  isSuccess.add(checkTrueMove.response['result']);
  isSuccess.add(checkThaiID.response['result']);

  return isSuccess.every((element) => element);
}
