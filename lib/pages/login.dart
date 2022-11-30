import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/apis/request/create_account.request.dart';
import 'package:tms/models/product_group.model.dart';
import 'package:tms/models/user_account.model.dart';
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

  // @override
  // void initState() {
  //   super.initState();
  //   _user.text = '1234567';
  //   _password.text = 'oooo0000';
  // }

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
                  hintText: 'รหัสพนักงาน',
                  maxLength: 8,
                  height: 15,
                  required: false,
                  showTextLable: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: [TextInputFormatter.filterInputNumber],
                  errorTextColor: Colors.white,
                  validator: (user) {
                    if (user!.isEmpty) return 'กรุณาใส่รหัสพนักงาน';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                formField(
                  controller: _password,
                  hintText: 'รหัสผ่าน',
                  maxLength: 8,
                  required: false,
                  showTextLable: false,
                  inputFormatters: [TextInputFormatter.filterInputENxNumber],
                  textInputAction: TextInputAction.done,
                  errorTextColor: Colors.white,
                  validator: (password) {
                    if (password!.isEmpty) return 'กรุณาใส่รหัสผ่าน';
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
                      Store.userTextInput.value = _user.text;
                      Call.raw(
                        method: Method.post,
                        url: '$hostTrue/user/v1/token/access',
                        body: {
                          "deviceId": Store.deviceSerial.value,
                          "user": _user.text,
                          "password": _password.text,
                        },
                      ).then((login) async {
                        if (login.success) {
                          //เก็บ TOKEN
                          UserTokenAccessModel userTokenAccess = UserTokenAccessModel.fromJson(login.response);
                          Store.token.value = userTokenAccess.token;

                          String encryptedEmployeeId = encrypt(_user.text);

                          //เรียกข้อมูลตำแหน่งงานกรณียังไม่ถูกเรียก
                          if (Store.userRoles.isEmpty) {
                            Call.raw(
                              method: Method.get,
                              url: '$hostTrue/content/v1/user-roles',
                            ).then((userRoles) {
                              if (userRoles.success) Store.userRoles.value = userRoles.response;
                            });
                          }

                          //เรียกข้อมูลโปรไฟล์และข้อมูลยอดขาย
                          await Future.wait([
                            Call.raw(
                              method: Method.get,
                              url: '$hostTrue/user/v1/accounts/$encryptedEmployeeId',
                              headers: Authorization.token,
                            ).then((userAccount) {
                              if (userAccount.success) Store.userAccountModel = UserAccountModel.fromJson(userAccount.response).obs;
                            }),
                            Call.raw(
                              method: Method.get,
                              url: '$hostTrue/product-group/v1/productGroup/$encryptedEmployeeId',
                              headers: Authorization.token,
                            ).then((productGroup) {
                              if (productGroup.success) Store.productGroupModel = ProductGroupModel.fromJson(productGroup.response).obs;
                            })
                          ]);

                          //เข้าหน้าเมนู
                          navigatorOffAll(() => const Menu());
                        }
                      });
                    }
                  },
                  child: text('เข้าสู่ระบบ', color: Colors.white, fontSize: 24),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                  GestureDetector(
                    onTap: () async {
                      bool isSuccess = await callCreateAccount();
                      if (isSuccess) navigatorTo(() => const ForgotPassword());
                    },
                    child: text('ลืมรหัสผ่าน', color: Colors.white, decoration: TextDecoration.underline),
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool isSuccess = await callCreateAccount();
                      if (isSuccess) navigatorTo(() => const CreateAccount());
                    },
                    child: text('สร้างบัญชีใหม่', color: Colors.white, decoration: TextDecoration.underline),
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
