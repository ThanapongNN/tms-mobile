import 'package:flutter/material.dart';
import 'package:tms/widgets/list_product_group.dart';

// ignore: camel_case_types
class productGroupPage extends StatefulWidget {
  final List data;
  const productGroupPage({super.key, required this.data});

  @override
  State<productGroupPage> createState() => _productGroupPageState();
}

// ignore: camel_case_types
class _productGroupPageState extends State<productGroupPage> {
  List data = [];

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    print(data[0].order);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return listProductGroup(
              icon: 'assets/images/sim.svg',
              title: data[index].order,
              quantity: data[index].orderTotal,
              unit: data[index].unit,
              seeDetail: (data[index].orderTotal == '0') ? false : true,
              detail: data[index].serviceCampaign);
        },
        childCount: data.length,
      ),
    );
  }
}
