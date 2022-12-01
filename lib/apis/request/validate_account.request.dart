import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';

Future<bool> validateAccountRequest({required String saleID, required String msisdn}) async {
  List<bool> isSuccess = [];

  CallBack checkSaleID = await Call.raw(
    method: Method.get,
    url: '$hostTrue/user/v1/check/$saleID',
  );

  CallBack checkTrueMove = await Call.raw(
    method: Method.post,
    url: '$hostTrue/support/v1/truemobile/validation',
    body: {"msisdn": msisdn},
  );

  isSuccess.add(checkSaleID.success);
  isSuccess.add(checkTrueMove.success);

  return isSuccess.every((element) => element);
}
