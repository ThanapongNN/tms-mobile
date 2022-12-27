// To parse this JSON data, do
//
//     final userAccountModel = userAccountModelFromJson(jsonString);

import 'dart:convert';

class UserAccountModel {
  UserAccountModel({
    required this.code,
    required this.description,
    required this.transactionId,
    required this.account,
  });

  final String code;
  final String description;
  final String transactionId;
  final Account account;

  factory UserAccountModel.fromRawJson(String str) => UserAccountModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserAccountModel.fromJson(Map<String, dynamic> json) => UserAccountModel(
        code: json["code"],
        description: json["description"],
        transactionId: json["transactionId"],
        account: Account.fromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "transactionId": transactionId,
        "account": account.toJson(),
      };
}

class Account {
  Account({
    required this.partnerCode,
    required this.partnerName,
    required this.partnerTypeCode,
    required this.createAt,
    required this.status,
    required this.employee,
  });

  final String partnerCode;
  final String partnerName;
  final String partnerTypeCode;
  final DateTime createAt;
  final String status;
  final Employee employee;

  factory Account.fromRawJson(String str) => Account.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        partnerCode: json["partnerCode"],
        partnerName: json["partnerName"],
        partnerTypeCode: json["partnerTypeCode"],
        createAt: DateTime.parse(json["create_at"]),
        status: json["status"],
        employee: Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "partnerName": partnerName,
        "partnerTypeCode": partnerTypeCode,
        "create_at": createAt.toIso8601String(),
        "status": status,
        "employee": employee.toJson(),
      };
}

class Employee {
  Employee({
    required this.id,
    required this.empId,
    required this.name,
    required this.surname,
    required this.birthdate,
    required this.mobile,
    required this.email,
    required this.roleCode,
    required this.roleName,
  });

  final String id;
  final String empId;
  final String name;
  final String surname;
  final DateTime birthdate;
  final String mobile;
  final String email;
  final String roleCode;
  final RoleName roleName;

  factory Employee.fromRawJson(String str) => Employee.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        empId: json["emp_id"],
        name: json["name"],
        surname: json["surname"],
        birthdate: DateTime.parse(json["birthdate"]),
        mobile: json["mobile"],
        email: json["email"],
        roleCode: json["roleCode"],
        roleName: RoleName.fromJson(json["roleName"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "emp_id": empId,
        "name": name,
        "surname": surname,
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "mobile": mobile,
        "email": email,
        "roleCode": roleCode,
        "roleName": roleName.toJson(),
      };
}

class RoleName {
  RoleName({
    required this.nameTh,
    required this.nameEn,
  });

  final String nameTh;
  final String nameEn;

  factory RoleName.fromRawJson(String str) => RoleName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoleName.fromJson(Map<String, dynamic> json) => RoleName(
        nameTh: json["name_th"],
        nameEn: json["name_en"],
      );

  Map<String, dynamic> toJson() => {
        "name_th": nameTh,
        "name_en": nameEn,
      };
}
