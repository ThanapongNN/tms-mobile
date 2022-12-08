import 'dart:async';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tms/widgets/button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AcceptTerms extends StatefulWidget {
  const AcceptTerms({super.key});

  @override
  State<AcceptTerms> createState() => _AcceptTermsState();
}

class _AcceptTermsState extends State<AcceptTerms> {
  final GlobalKey webViewKey = GlobalKey();

  late WebViewController _controller;
  InAppWebViewController? webViewController;

  bool disable = true;
  int? contentHeight, scrollY;
  void disableButton() async {
    int y = await _controller.getScrollY();

    print(y);
  }

  Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เงื่อนไขและข้อตกลง')),
      body: InAppWebView(
        key: webViewKey,
        initialUrlRequest: URLRequest(url: Uri.parse('https://truevirtualworld.com/en/vlearn/terms-and-conditions')),
        onWebViewCreated: (controller) => webViewController = controller,
        // onLoadStop: (controller, url) async {
        //   contentHeight = await webViewController!.getContentHeight();
        //   print(contentHeight);

        //   _timer = Timer.periodic(
        //     const Duration(seconds: 2),
        //     (timer) async {
        //       scrollY = await webViewController!.getScrollY();
        //       print(scrollY);
        //       if (scrollY == contentHeight) {
        //         _timer?.cancel();
        //       }
        //     },
        //   );
        // },
        onScrollChanged: (controller, x, y) async {
          print(controller);
        },
        gestureRecognizers: {Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())},
      ),
      bottomNavigationBar: Container(
        height: 150,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 10),
          button(text: 'ยอมรับเงื่อนไข ', icon: BootstrapIcons.check, disable: true),
          const SizedBox(height: 10),
          button(text: 'ยกเลิก', icon: BootstrapIcons.x, outline: true),
        ]),
      ),
    );
  }
}
