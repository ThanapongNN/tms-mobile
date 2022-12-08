import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/route_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/pages/account/confirm_otp.dart';
import 'package:tms/state_management.dart';
import 'package:tms/utils/constructor.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/navigator.dart';

class AcceptTerms extends StatefulWidget {
  const AcceptTerms({super.key});

  @override
  State<AcceptTerms> createState() => _AcceptTermsState();
}

class _AcceptTermsState extends State<AcceptTerms> {
  bool disable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เงื่อนไขและข้อตกลง')),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse('https://truevirtualworld.com/en/vlearn/terms-and-conditions')),
        onOverScrolled: (controller, x, y, clampedX, clampedY) {
          if (clampedY && disable) setState(() => disable = false);
        },
        gestureRecognizers: {Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())},
      ),
      bottomNavigationBar: Container(
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 10),
          button(
            text: 'ยอมรับเงื่อนไข ',
            icon: BootstrapIcons.check,
            disable: disable,
            onPressed: () {
              Call.raw(
                method: Method.post,
                url: '$host/support/v1/otp/request',
                body: {"msisdn": Store.registerBody['employee']['mobile']},
              ).then((otpRequest) {
                if (otpRequest.success) {
                  Store.otpRefID.value = otpRequest.response['refId'];

                  navigatorTo(
                    () => ConfirmOTP(otp: OTP.createAccount, mobileNO: Store.registerBody['employee']['mobile']),
                    transition: Transition.rightToLeft,
                  );
                }
              });
            },
          ),
          const SizedBox(height: 10),
          button(text: 'ยกเลิก', icon: BootstrapIcons.x, outline: true),
        ]),
      ),
    );
  }
}
