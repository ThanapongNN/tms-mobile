import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tms/widgets/text.dart';

class SellerRank extends StatelessWidget {
  const SellerRank({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: text(text: 'อันดับนักขาย'));
  }
}