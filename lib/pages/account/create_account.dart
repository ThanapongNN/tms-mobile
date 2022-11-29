import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:tms/apis/call.dart';
import 'package:tms/apis/config.dart';
import 'package:tms/models/partner_types.model.dart';
import 'package:tms/models/shop_profile_list.model.dart';
import 'package:tms/models/user_roles.model.dart';
import 'package:tms/pages/account/accept_terms.dart';
import 'package:tms/pages/account/confirm_otp.dart';
import 'package:tms/state_management.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/utils/constructor.dart';
import 'package:tms/utils/screen.dart';
import 'package:tms/utils/text_input_formatter.dart';
import 'package:tms/utils/validate_thai_national_id.dart';
import 'package:tms/widgets/button.dart';
import 'package:tms/widgets/dialog.dart';
import 'package:tms/widgets/dropdown.dart';
import 'package:tms/widgets/form_field.dart';
import 'package:tms/widgets/list_string_number.dart';
import 'package:tms/widgets/navigator.dart';
import 'package:tms/widgets/text.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _saleID = TextEditingController();
  final _thaiID = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _email = TextEditingController();
  final _branch = TextEditingController();
  final _jobBranch = TextEditingController();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  bool accept = false;
  bool disable = true;
  bool errorAccept = false;
  bool errorDay = false;
  bool errorMonth = false;
  bool errorYear = false;
  bool errorJob = false;

  bool is711 = true;

  Color borderDay = Colors.grey;
  Color borderMonth = Colors.grey;
  Color borderYear = Colors.grey;
  Color borderJob = Colors.grey;

  List<bool> selectShop = [
    true,
    false,
    false,
    false,
  ];

  List<String> nameShop = [], itemsJobs = [], itemsDays = [], itemsYears = [];

  String? selectedDay, selectedMonth, selectedYear, selectedJob;

  PartnerTypesModel partner = PartnerTypesModel.fromJson(Store.partnerTypes);
  UserRolesModel user = UserRolesModel.fromJson(Store.userRoles);

  @override
  void initState() {
    super.initState();

    nameShop = partner.partnerTypes.map((e) => e.name.th).toList();
    itemsJobs = user.userRoles.map((e) => e.name.th).toList();
    itemsDays = listStringNumber(start: 1, end: 31);
    itemsYears = listStringNumber(start: ((DateTime.now().year + 543) - 100), end: (DateTime.now().year + 543), invert: true);
  }

  void checkAllInput() {
    if ((_saleID.text.length > 6) &&
        _firstName.text.isNotEmpty &&
        _lastName.text.isNotEmpty &&
        (selectedDay != null) &&
        (selectedMonth != null) &&
        (selectedYear != null) &&
        (_phoneNumber.text.length == 12) &&
        (selectedJob != null) &&
        (_branch.text.length == 5) &&
        _jobBranch.text.isNotEmpty &&
        accept) {
      disable = false;
    } else {
      disable = true;
    }
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

      if (selectedJob == null) {
        borderJob = Colors.red;
        errorJob = true;
        isValid = false;
      }

      if (!accept) {
        errorAccept = true;
        isValid = false;
      }
    });

    return isValid;
  }

  Widget rowForm(Widget inputLeft, Widget inputRight) {
    return Row(children: [
      Expanded(child: inputLeft),
      const SizedBox(width: 10),
      Expanded(child: inputRight),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('สร้างบัญชีใหม่')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: text('เลือกร้านค้าปฏิบัติงาน', fontSize: 24).paddingAll(10)),
              Wrap(
                children: nameShop.map<Widget>((e) {
                  return SizedBox(
                    width: (Screen.width(context) / 2) - 40,
                    child: Row(children: [
                      Checkbox(
                        value: selectShop[nameShop.indexOf(e)],
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (value) {
                          // setState(() {
                          //   selectShop = [false, false, false, false, false];
                          //   selectShop[index] = value!;
                          // });
                        },
                      ),
                      Expanded(
                        child: text(
                          nameShop[nameShop.indexOf(e)],
                          color: nameShop.indexOf(e) == 0 ? Colors.black : Colors.grey,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ]),
                  );
                }).toList(),
              ).paddingSymmetric(horizontal: 20),
              Divider(thickness: 5, color: Colors.grey[200]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Center(child: text('ข้อมูลพนักงานขาย', fontSize: 24).paddingAll(10)),
                rowForm(
                  formField(
                    controller: _saleID,
                    textLable: 'รหัสพนักงาน',
                    hintText: 'กรุณากรอกรหัสพนักงาน',
                    maxLength: is711 ? 7 : 8,
                    keyboardType: TextInputType.number,
                    inputFormatters: [TextInputFormatter.filterInputNumber],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณาระบุรหัสพนักงาน\n';
                      } else if (value.length != 7) {
                        return 'รหัสพนักงานไม่ถูกต้อง\n';
                      }
                      return null;
                    },
                    onChanged: (v) => setState(() => checkAllInput()),
                  ),
                  formField(
                    controller: _thaiID,
                    textLable: 'เลขบัตรประชาชน',
                    hintText: 'กรุณากรอกเลขบัตรประชาชน',
                    maxLength: 17,
                    keyboardType: TextInputType.number,
                    inputFormatters: [TextInputFormatter.maskTextIDCardTH],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณาระบุเลขบัตรประชาชน\n';
                      } else if ((value.length != 17) || !validateThaiNationalID(value.replaceAll('-', ''))) {
                        return 'เลขบัตรประชาชนไม่ถูกต้อง\n';
                      }
                      return null;
                    },
                    onChanged: (v) => setState(() => checkAllInput()),
                  ),
                ),
                rowForm(
                  formField(
                    controller: _firstName,
                    textLable: 'ชื่อ',
                    hintText: 'กรุณากรอกชื่อ',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณาระบุชื่อ\n';
                      }
                      return null;
                    },
                    onChanged: (v) => setState(() => checkAllInput()),
                  ),
                  formField(
                    controller: _lastName,
                    textLable: 'นามสกุล',
                    hintText: 'กรุณากรอกนามสกุล',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณาระบุนามสกุล\n';
                      }
                      return null;
                    },
                    onChanged: (v) => setState(() => checkAllInput()),
                  ),
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
                rowForm(
                  formField(
                    controller: _phoneNumber,
                    textLable: 'เบอร์มือถือ',
                    hintText: 'กรุณากรอกเบอร์มือถือ',
                    keyboardType: TextInputType.phone,
                    inputFormatters: [TextInputFormatter.maskTextPhoneNumber],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณาระบุเบอร์โทรศัพท์มือถือ\n';
                      } else if (!value.startsWith(RegExp(r'06|08|09'))) {
                        return 'กรุณาระบุเบอร์โทรศัพท์มือถือ เพื่อใช้รับรหัสยืนยันการสร้างบัญชี\n';
                      } else if (value.length != 12) {
                        return 'กรุณาระบุเบอร์โทรศัพท์มือถือจำนวน 10 หลัก\n';
                      }

                      return null;
                    },
                    onChanged: (v) => setState(() => checkAllInput()),
                  ),
                  formField(
                    controller: _email,
                    textLable: 'อีเมล',
                    hintText: 'กรุณากรอกอีเมล',
                    required: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isNotEmpty && !EmailValidator.validate(value)) {
                        return 'กรุณาระบุอีเมลตามรูปแบบที่ถูกต้อง\n';
                      }
                      return null;
                    },
                  ),
                ),
                rowForm(
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      text('ตำแหน่งงาน', fontSize: 18),
                      text('*', fontSize: 20, color: Colors.red),
                    ]),
                    Row(children: [
                      dropdown(
                        hint: 'เลือกตำแหน่งงาน',
                        items: itemsJobs,
                        selectedValue: selectedJob,
                        borderColor: borderJob,
                        onMenuStateChange: (isOpen) {
                          setState(() {
                            borderJob = isOpen ? ThemeColor.primaryColor : Colors.grey;
                          });
                        },
                        onChanged: (job) {
                          setState(() {
                            borderJob = Colors.grey;
                            errorJob = false;
                            selectedJob = job;
                            checkAllInput();
                          });
                        },
                      ),
                    ]),
                    if (errorJob) text('กรุณาตำแหน่งงาน', color: ThemeColor.primaryColor, fontSize: 12).paddingOnly(left: 10),
                  ]).paddingOnly(bottom: 10),
                  formField(
                    controller: _branch,
                    textLable: 'รหัสสาขาทรู',
                    hintText: ' ค้นหารหัสสาขาทรู',
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    inputFormatters: [TextInputFormatter.filterInputNumber],
                    textInputAction: TextInputAction.done,
                    prefixIcon: text('  711', fontSize: 18),
                    prefixIconConstraints: const BoxConstraints(minHeight: 29),
                    suffixIcon: const Icon(BootstrapIcons.search),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณาระบุรหัสสาขาทรูปฏิบัติงาน\n';
                      } else if (value.length != 5) {
                        return 'รหัสสาขาทรูไม่ถูกต้อง\n';
                      }
                      return null;
                    },
                    onChanged: (value) async {
                      // _branch.selection = TextSelection.fromPosition(TextPosition(offset: _branch.text.length));
                      if (_branch.text.length == 5) {
                        _jobBranch.clear();

                        CallBack data = await Call.raw(
                          method: Method.get,
                          url: '$hostTrue/content/v1/partners/711${_branch.text}',
                        );

                        if (data.success) {
                          if (data.response['partner'] != null) {
                            ShopProfileListModel shopProfileList = ShopProfileListModel.fromJson(data.response);
                            // _branch.text = shopProfileList.partner[0].code;
                            _jobBranch.text = shopProfileList.partner[0].name.th;
                          } else {
                            dialog(content: 'ไม่พบรหัสสาขาทรูในระบบ');
                          }
                        }
                      }

                      checkAllInput();
                    },
                  ),
                ),
                formField(
                  controller: _jobBranch,
                  textLable: 'สาขาปฏิบัติงาน',
                  required: false,
                  disable: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณาระบุรหัสสาขาทรูให้ถูกต้อง\n';
                    }
                    return null;
                  },
                  onChanged: (v) => setState(() => checkAllInput()),
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: ThemeColor.primaryColor,
                    side: const BorderSide(width: 2, color: Colors.grey),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: accept,
                    onChanged: (bool? v) => setState(() {
                      accept = v!;
                      errorAccept = !v;
                      checkAllInput();
                    }),
                    tristate: false,
                  ),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        text: 'ยอมรับเงื่อนไข ',
                        style: const TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Kanit'),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () => navigatorTo(() => const AcceptTerms()),
                            text: 'ข้อตกลงร่วมใช้และเข้าถึงข้อมูลของผู้ใช้บริการผ่านแอฟพลิเคชั้นนี้',
                            style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
                if (errorAccept)
                  text(
                    'กรุณากดยอมรับเงื่อนไข ก่อนยืนยันสร้างบัญชี',
                    color: ThemeColor.primaryColor,
                    fontSize: 12,
                  ).paddingOnly(left: 10),
                const SizedBox(height: 20),
                button(
                  text: 'สร้างบัญชี',
                  icon: BootstrapIcons.plus,
                  disable: disable,
                  onPressed: disable
                      ? () {}
                      : () async {
                          if (_validateForm()) {
                            CallBack check = await Call.raw(
                              method: Method.get,
                              url: '$hostTrue/user/v1/check/${_saleID.text}',
                            );

                            if (check.success) {
                              CallBack data = await Call.raw(
                                method: Method.post,
                                url: '$hostTrue/support/v1/otp/request',
                                body: {"msisdn": _phoneNumber.text.replaceAll('-', '')},
                              );

                              if (data.success) {
                                Store.otpRefID.value = data.response['refId'];
                                Store.registerBody.value = {
                                  "otpRefId": '',
                                  "partnerTypeCode": partner.partnerTypes[selectShop.indexOf(true)].code,
                                  "partnerCode": '711${_branch.text}',
                                  "partnerName": _jobBranch.text,
                                  "employee": {
                                    "thaiId": _thaiID.text.replaceAll('-', ''),
                                    "id": _saleID.text,
                                    "password": '',
                                    "name": _firstName.text,
                                    "surname": _lastName.text,
                                    "birthdate":
                                        '${DateTime.parse('${int.parse(selectedYear!) - 543}-${(itemsMonths.indexOf(selectedMonth!) + 1).toString().padLeft(2, '0')}-${selectedDay!.padLeft(2, '0')}')}',
                                    "mobile": _phoneNumber.text.replaceAll('-', ''),
                                    "email": _email.text,
                                    "roleCode": user.userRoles[itemsJobs.indexOf(selectedJob!)].code,
                                  }
                                };

                                navigatorTo(
                                  () => ConfirmOTP(otp: OTP.createAccount, mobileNO: Store.registerBody['employee']['mobile']),
                                  transition: Transition.rightToLeft,
                                );
                              }
                            }
                          }
                        },
                ),
                const SizedBox(height: 10),
                button(text: 'ยกเลิก', icon: BootstrapIcons.x, outline: true),
              ]).paddingSymmetric(horizontal: 20),
            ]),
          ),
        ),
      ),
    );
  }
}
