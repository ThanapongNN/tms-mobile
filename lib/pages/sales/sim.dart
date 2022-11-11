import 'package:flutter/material.dart';
import 'package:tms/widgets/list_sales.dart';

class SalesSim extends StatelessWidget {
  final List data;
  const SalesSim({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return listSales(
            icon: data[index]['icon'],
            title: data[index]['title'],
            content: data[index]['content'],
          );
        },
        childCount: data.length,
      ),
    );
  }
}
