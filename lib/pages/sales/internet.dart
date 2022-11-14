import 'package:flutter/material.dart';
import 'package:tms/widgets/list_sales.dart';

class SalesInternet extends StatelessWidget {
  final List data;
  const SalesInternet({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return listSales(
            icon: data[index]['icon'],
            title: data[index]['title'],
            quantity: data[index]['quantity'],
            unit: data[index]['unit'],
          );
        },
        childCount: data.length,
      ),
    );
  }
}
