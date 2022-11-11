import 'package:flutter/material.dart';

class NewDetail extends StatefulWidget {
  const NewDetail({super.key});

  @override
  State<NewDetail> createState() => _NewDetailState();
}

class _NewDetailState extends State<NewDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('รายละเอียด')),
    );
  }
}
