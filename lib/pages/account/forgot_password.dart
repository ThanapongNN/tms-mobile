import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/models/forgot_password.model.dart';
import 'package:tms/models/user_roles.model.dart';
import 'package:tms/pages/account/confirm_otp.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/constructor.dart';
import 'package:tms/utils/text_input_formatter.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/dropdown.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/list_string_number.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _saleID = TextEditingController();
  final _branch = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  bool disable = true;
  bool errorDay = false;
  bool errorMonth = false;
  bool errorYear = false;

  Color borderDay = Colors.grey;
  Color borderMonth = Colors.grey;
  Color borderYear = Colors.grey;

  List<String> itemsDays = [], itemsYears = [];

  String? selectedDay, selectedMonth, selectedYear;

  UserRolesModel user = UserRolesModel.fromJson(Store.userRoles);

  @override
  void initState() {
    super.initState();
    itemsDays = listStringNumber(start: 1, end: 31);
    itemsYears = listStringNumber(start: ((DateTime.now().year + 543) - 100), end: (DateTime.now().year + 543), invert: true);
  }

  bool _validateForm() {
    bool isValid = _formKey.currentState!.validate();

    setState(() {
      _autovalidateMode = AutovalidateMode.onUserInteraction;

      if (selectedDay == null) {
        borderDay = Colors.red;
        errorDay = true;
        isValid = false;
      }

      if (selectedMonth == null) {
        borderMonth = Colors.red;
        errorMonth = true;
        isValid = false;
      }

      if (selectedYear == null) {
        borderYear = Colors.red;
        errorYear = true;
        isValid = false;
      }
    });

    return isValid;
  }

  void checkAllInput() {
    if ((_saleID.text.length > 6) && (_branch.text.length == 8) && (selectedDay != null) && (selectedMonth != null) && (selectedYear != null)) {
      disable = false;
    } else {
      disable = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('ลืมรหัสผ่าน')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: text('กรุณาระบุข้อมูล\nเพื่อกำหนดรหัสผ่านใหม่', fontSize: 24, textAlign: TextAlign.center).paddingAll(20)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                formField(
                  controller: _saleID,
                  textLable: 'รหัสพนักงาน',
                  hintText: 'กรุณากรอกรหัสพนักงาน',
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                  inputFormatters: [TextInputFormatter.filterInputNumber],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุรหัสพนักงาน';
                    }
                    return null;
                  },
                  onChanged: (v) => setState(() => checkAllInput()),
                ),
                formField(
                  controller: _branch,
                  textLable: 'รหัสสาขาทรู',
                  hintText: 'กรุณากรอกรหัสสาขาทรู',
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                  inputFormatters: [TextInputFormatter.filterInputNumber],
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุรหัสสาขาทรูปฏิบัติงาน';
                    } else if (value.length != 8) {
                      return 'รหัสสาขาทรูไม่ถูกต้อง';
                    }
                    return null;
                  },
                  onChanged: (v) => setState(() => checkAllInput()),
                ),
                Row(children: [
                  text('วันเดือนปีเกิด', fontSize: 18),
                  text('*', fontSize: 20, color: Colors.red),
                ]),
                Row(children: [
                  dropdown(
                    flex: 2,
                    hint: 'วัน',
                    items: itemsDays,
                    selectedValue: selectedDay,
                    borderColor: borderDay,
                    onMenuStateChange: (isOpen) {
                      setState(() {
                        borderDay = isOpen ? ThemeColor.primaryColor : Colors.grey;
                      });
                    },
                    onChanged: (day) {
                      setState(() {
                        borderDay = Colors.grey;
                        errorDay = false;
                        selectedDay = day;
                        checkAllInput();
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  dropdown(
                    flex: 3,
                    hint: 'เดือน',
                    items: itemsMonths,
                    selectedValue: selectedMonth,
                    borderColor: borderMonth,
                    onMenuStateChange: (isOpen) {
                      setState(() {
                        borderMonth = isOpen ? ThemeColor.primaryColor : Colors.grey;
                      });
                    },
                    onChanged: (month) {
                      int year = DateTime.now().year;
                      if (selectedYear != null) year = (int.parse(selectedYear!) - 543);

                      int endDay = DateTime(year, (itemsMonths.indexOf(month!) + 2), 0).day;
                      if (selectedDay != null) {
                        if (endDay < int.parse(selectedDay!)) selectedDay = endDay.toString();
                      }
                      itemsDays = listStringNumber(start: 1, end: endDay);

                      setState(() {
                        borderMonth = Colors.grey;
                        errorMonth = false;
                        selectedMonth = month;
                        checkAllInput();
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  dropdown(
                    flex: 3,
                    hint: 'ปี',
                    items: itemsYears,
                    selectedValue: selectedYear,
                    borderColor: borderYear,
                    onMenuStateChange: (isOpen) {
                      setState(() {
                        borderYear = isOpen ? ThemeColor.primaryColor : Colors.grey;
                      });
                    },
                    onChanged: (year) {
                      if (selectedMonth != null) {
                        int mouth = (itemsMonths.indexOf(selectedMonth!) + 2);
                        int endDay = DateTime((int.parse(year!) - 543), mouth, 0).day;
                        if (selectedDay != null) {
                          if (endDay < int.parse(selectedDay!)) selectedDay = endDay.toString();
                        }
                        itemsDays = listStringNumber(start: 1, end: endDay);
                      }

                      setState(() {
                        borderYear = Colors.grey;
                        errorYear = false;
                        selectedYear = year;
                        checkAllInput();
                      });
                    },
                  ),
                ]),
                Row(children: [
                  Expanded(
                    flex: 2,
                    child: errorDay
                        ? text('กรุณาเลือกวัน', color: ThemeColor.primaryColor, fontSize: 12).paddingOnly(left: 10)
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: errorMonth
                        ? text('กรุณาเลือกเดือน', color: ThemeColor.primaryColor, fontSize: 12).paddingOnly(left: 10)
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: errorYear
                        ? text('กรุณาเลือกปี', color: ThemeColor.primaryColor, fontSize: 12).paddingOnly(left: 10)
                        : const SizedBox.shrink(),
                  ),
                ]).paddingOnly(bottom: 10),
                const SizedBox(height: 20),
                button(
                  text: 'ถัดไป',
                  icon: BootstrapIcons.arrow_right,
                  disable: disable,
                  onPressed: disable
                      ? () {}
                      : () async {
                          if (_validateForm()) {
                            Store.saleID.value = _saleID.text;

                            Call.raw(
                              method: Method.post,
                              url: '$host/user/v1/accounts/${_saleID.text}',
                              body: {
                                "partnerCode": _branch.text,
                                "birthdate":
                                    '${DateTime.parse('${int.parse(selectedYear!) - 543}-${(itemsMonths.indexOf(selectedMonth!) + 1).toString().padLeft(2, '0')}-${selectedDay!.padLeft(2, '0')}')}',
                              },
                            ).then((forgotPassword) {
                              if (forgotPassword.success) {
                                Store.forgotPasswordModel = ForgotPasswordModel.fromJson(forgotPassword.response).obs;

                                Call.raw(
                                  method: Method.post,
                                  url: '$host/support/v1/otp/request',
                                  body: {"msisdn": Store.forgotPasswordModel!.value.mobile},
                                ).then((otp) {
                                  if (otp.success) {
                                    Store.otpRefID.value = otp.response['refId'];
                                    navigatorTo(
                                      () => ConfirmOTP(
                                        otp: OTP.forgotPassword,
                                        mobileNO: Store.forgotPasswordModel!.value.mobile,
                                      ),
                                      transition: Transition.rightToLeft,
                                    );
                                  }
                                });
                              }
                            });
                          }
                        },
                ),
                const SizedBox(height: 10),
                button(text: 'ยกเลิก', icon: BootstrapIcons.x, outline: true),
              ]).paddingSymmetric(horizontal: 40)
            ]),
          ),
        ),
      ),
    );
  }
}
