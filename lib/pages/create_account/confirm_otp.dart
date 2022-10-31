import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/route_manager.dart';
import 'package:tms/pages/create_account/new_password.dart';
import 'package:tms/widgets/tms_button.dart';

class ConfirmOTP extends StatefulWidget {
  const ConfirmOTP({super.key});

  @override
  State<ConfirmOTP> createState() => _ConfirmOTPState();
}

class _ConfirmOTPState extends State<ConfirmOTP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('สร้างบัญชีใหม่')),
    );
  }
}
