import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/package_version.dart';

void main() {
  configLoading();
  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.light
    // ..maskType = EasyLoadingMaskType.custom
    // ..maskColor = Colors.black.withOpacity(0.1)
    ..radius = 10
    ..contentPadding = const EdgeInsets.all(14)
    ..indicatorWidget = Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
      child: const LoadingIndicator(indicatorType: Indicator.ballPulse, colors: [ThemeColor.primaryColor], strokeWidth: 4),
    )
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); //ปรับให้แอปเป็นแนวตั้ง
    Intl.defaultLocale = 'th'; //ตั้งภาษาแรกตามพื้นที่
    initializeDateFormatting('th', null); //ตั้งปฏิทินแรกตามพื้นที่
    packageVersion(); //ดึงค่าเวอร์ชั่นแอป

    return GetMaterialApp(
      title: 'TMS ช่วยขาย true',
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      builder: EasyLoading.init(builder: (context, widget) {
        return ResponsiveWrapper.builder(
          widget,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
        );
      }),
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFFD4364E, <int, Color>{
          50: Color(0xFFD4364E),
          100: Color(0xFFD4364E),
          200: Color(0xFFD4364E),
          300: Color(0xFFD4364E),
          400: Color(0xFFD4364E),
          500: Color(0xFFD4364E),
          600: Color(0xFFD4364E),
          700: Color(0xFFD4364E),
          800: Color(0xFFD4364E),
          900: Color(0xFFD4364E),
        }),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Kanit',
        appBarTheme: const AppBarTheme(centerTitle: true, titleTextStyle: TextStyle(fontSize: 24, fontFamily: 'Kanit')),
        textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 20), button: TextStyle(fontSize: 24)),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(fontSize: 16, color: Colors.black54),
          hintStyle: const TextStyle(color: Colors.grey),
          counterStyle: const TextStyle(fontSize: 0),
        ),
      ),
    );
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
