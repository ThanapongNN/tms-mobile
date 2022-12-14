import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/apis/request/create_account.request.dart';
import 'package:tms/apis/request/first_login.request.dart';
import 'package:tms/models/user_token_access.model.dart';
import 'package:tms/pages/account/create_account.dart';
import 'package:tms/pages/account/forgot_password.dart';
import 'package:tms/pages/menu.dart';
import 'package:tms/state_management.dart';
import 'package:tms/utils/encrypt.dart';
import 'package:tms/utils/text_input_formatter.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _user = TextEditingController();
  final _password = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _hideText = true;

  @override
  void initState() {
    super.initState();
    // _user.text = '0724719';
    // _password.text = '123456aa';
    // _user.text = '5761884';
    // _password.text = '123456bb';
    // _user.text = '1234567';
    // _password.text = 'aaaaaaa1';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          alignment: Alignment.bottomCenter,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(children: [
                Image.asset('assets/images/logo.png', scale: 3),
                SizedBox(height: Get.height / 4),
                formField(
                  controller: _user,
                  hintText: '?????????????????????????????????',
                  maxLength: 8,
                  height: 15,
                  required: false,
                  showTextLable: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: [TextInputFormatter.filterInputNumber],
                  errorTextColor: Colors.white,
                  validator: (user) {
                    if (user!.isEmpty) return '?????????????????????????????????????????????????????????';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                formField(
                  controller: _password,
                  hintText: '????????????????????????',
                  maxLength: 8,
                  required: false,
                  showTextLable: false,
                  inputFormatters: [TextInputFormatter.filterInputENxNumber],
                  textInputAction: TextInputAction.done,
                  errorTextColor: Colors.white,
                  validator: (password) {
                    if (password!.isEmpty) return '????????????????????????????????????????????????';
                    return null;
                  },
                  obscureText: _hideText,
                  height: 15,
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _hideText = !_hideText),
                    icon: Icon(
                      _hideText ? BootstrapIcons.eye_slash : BootstrapIcons.eye_fill,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                MaterialButton(
                  height: 60,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                    side: const BorderSide(color: Colors.white),
                  ),
                  onPressed: () async {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.onUserInteraction;
                    });

                    if (_formKey.currentState!.validate()) {
                      await EasyLoading.show();

                      Store.currentIndex.value = 0;

                      Call.raw(
                        method: Method.post,
                        url: '$host/user/v1/token/access',
                        showLoading: false,
                        body: {
                          "deviceId": Store.deviceSerial.value,
                          "user": _user.text,
                          "password": _password.text,
                        },
                      ).then((login) async {
                        if (login.success) {
                          //???????????? TOKEN
                          UserTokenAccessModel userTokenAccess = UserTokenAccessModel.fromJson(login.response);
                          Store.token.value = userTokenAccess.token;
                          Store.encryptedEmployeeId.value = encrypt(_user.text);

                          //???????????????????????????????????????????????????????????????????????????????????????????????????
                          await firstLoginRequest(showLoading: false);

                          //????????????????????????????????????
                          Get.offAll(() => const Menu());
                        }
                        await EasyLoading.dismiss();
                      });
                    }
                  },
                  child: text('?????????????????????????????????', color: Colors.white, fontSize: 24),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  GestureDetector(
                    onTap: () async {
                      bool isSuccess = await createAccountRequest();
                      if (isSuccess) navigatorTo(() => const ForgotPassword());
                    },
                    child: text('?????????????????????????????????', color: Colors.white, decoration: TextDecoration.underline),
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool isSuccess = await createAccountRequest();
                      if (isSuccess) navigatorTo(() => const CreateAccount());
                    },
                    child: text('??????????????????????????????????????????', color: Colors.white, decoration: TextDecoration.underline),
                  ),
                ])
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
