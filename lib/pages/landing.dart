import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/local_storage.dart';
import 'package:tms/pages/login.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/text.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _host = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _host.text = host;
    _host.text = 'https://5cea-171-96-154-193.ap.ngrok.io';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.all(40),
          color: ThemeColor.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text('ระบุ Host ที่ใช้เชื่อมต่อ API', color: Colors.white),
              formField(controller: _host),
              const SizedBox(height: 20),
              button(
                text: 'บันทึก',
                outline: true,
                icon: Icons.save,
                onPressed: () async {
                  host = _host.text;
                  await LocalStorage.writeHost(host);

                  Get.offAll(const LoginPage());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
