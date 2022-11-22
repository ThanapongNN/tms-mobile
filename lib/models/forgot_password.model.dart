// To parse this JSON data, do
//
//     final forgotPasswordModel = forgotPasswordModelFromJson(jsonString);

import 'dart:convert';

class ForgotPasswordModel {
  ForgotPasswordModel({
    required this.code,
    required this.description,
    required this.transactionId,
    required this.employeeId,
    required this.mobile,
  });

  String code;
  String description;
  String transactionId;
  String employeeId;
  String mobile;

  factory ForgotPasswordModel.fromRawJson(String str) => ForgotPasswordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
        code: json["code"],
        description: json["description"],
        transactionId: json["transactionId"],
        employeeId: json["employeeId"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "transactionId": transactionId,
        "employeeId": employeeId,
        "mobile": mobile,
      };
}
