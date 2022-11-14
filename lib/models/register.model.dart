// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

class RegisterModel {
  RegisterModel({
    required this.partnerTypeCode,
    required this.partnerCode,
    required this.partnerName,
    required this.otpRefId,
    required this.employee,
  });

  String partnerTypeCode;
  String partnerCode;
  String partnerName;
  String otpRefId;
  Employee employee;

  factory RegisterModel.fromRawJson(String str) => RegisterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        partnerTypeCode: json["partnerTypeCode"],
        partnerCode: json["partnerCode"],
        partnerName: json["partnerName"],
        otpRefId: json["otpRefId"],
        employee: Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "partnerTypeCode": partnerTypeCode,
        "partnerCode": partnerCode,
        "partnerName": partnerName,
        "otpRefId": otpRefId,
        "employee": employee.toJson(),
      };
}

class Employee {
  Employee({
    required this.id,
    required this.password,
    required this.name,
    required this.surname,
    required this.birthdate,
    required this.mobile,
    required this.email,
    required this.roleCode,
  });

  String id;
  String password;
  String name;
  String surname;
  DateTime birthdate;
  String mobile;
  String email;
  String roleCode;

  factory Employee.fromRawJson(String str) => Employee.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        password: json["password"],
        name: json["name"],
        surname: json["surname"],
        birthdate: DateTime.parse(json["birthdate"]),
        mobile: json["mobile"],
        email: json["email"],
        roleCode: json["roleCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "name": name,
        "surname": surname,
        "birthdate": birthdate.toIso8601String(),
        "mobile": mobile,
        "email": email,
        "roleCode": roleCode,
      };
}
