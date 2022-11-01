import 'package:flutter/material.dart';
import 'package:tms/widgets/text.dart';

class Sale extends StatefulWidget {
  const Sale({super.key});

  @override
  State<Sale> createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: text(text: 'ยอดขาย'),
    );
  }
}
