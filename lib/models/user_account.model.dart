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

  int code;
  String description;
  String transactionId;
  Account account;

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
    required this.id,
    required this.partnerTypeCode,
    required this.employeeId,
    required this.password,
    required this.name,
    required this.surname,
    required this.birthdate,
    required this.mobileNo,
    required this.email,
    required this.image,
    required this.roleCode,
    required this.partnerCode,
    required this.partnerName,
    required this.createBy,
    required this.createDate,
    required this.createTransactionId,
    required this.updateBy,
    required this.updateDate,
    required this.deleteBy,
    required this.status,
    required this.deleteDate,
    required this.employee,
  });

  String id;
  String partnerTypeCode;
  String employeeId;
  String password;
  String name;
  String surname;
  DateTime birthdate;
  String mobileNo;
  String email;
  dynamic image;
  String roleCode;
  String partnerCode;
  String partnerName;
  String createBy;
  DateTime createDate;
  String createTransactionId;
  dynamic updateBy;
  dynamic updateDate;
  dynamic deleteBy;
  String status;
  dynamic deleteDate;
  Employee employee;

  factory Account.fromRawJson(String str) => Account.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        partnerTypeCode: json["partner_type_code"],
        employeeId: json["employee_id"],
        password: json["password"],
        name: json["name"],
        surname: json["surname"],
        birthdate: DateTime.parse(json["birthdate"]),
        mobileNo: json["mobile_no"],
        email: json["email"],
        image: json["image"],
        roleCode: json["role_code"],
        partnerCode: json["partner_code"],
        partnerName: json["partner_name"],
        createBy: json["create_by"],
        createDate: DateTime.parse(json["create_date"]),
        createTransactionId: json["create_transaction_id"],
        updateBy: json["update_by"],
        updateDate: json["update_date"],
        deleteBy: json["delete_by"],
        status: json["status"],
        deleteDate: json["delete_date"],
        employee: Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "partner_type_code": partnerTypeCode,
        "employee_id": employeeId,
        "password": password,
        "name": name,
        "surname": surname,
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "mobile_no": mobileNo,
        "email": email,
        "image": image,
        "role_code": roleCode,
        "partner_code": partnerCode,
        "partner_name": partnerName,
        "create_by": createBy,
        "create_date": createDate.toIso8601String(),
        "create_transaction_id": createTransactionId,
        "update_by": updateBy,
        "update_date": updateDate,
        "delete_by": deleteBy,
        "status": status,
        "delete_date": deleteDate,
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
  });

  String id;
  String empId;
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
        empId: json["emp_id"],
        name: json["name"],
        surname: json["surname"],
        birthdate: DateTime.parse(json["birthdate"]),
        mobile: json["mobile"],
        email: json["email"],
        roleCode: json["roleCode"],
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
      };
}
