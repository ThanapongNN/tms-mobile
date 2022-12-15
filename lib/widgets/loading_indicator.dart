import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tms/theme/color.dart';

Widget loadingIndicator() {
  return Center(
    child: Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
      child: const LoadingIndicator(indicatorType: Indicator.lineSpinFadeLoader, colors: [ThemeColor.primaryColor], strokeWidth: 4),
    ),
  );
}
