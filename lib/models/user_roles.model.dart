// To parse this JSON data, do
//
//     final userRolesModel = userRolesModelFromJson(jsonString);

import 'dart:convert';

class UserRolesModel {
  UserRolesModel({
    required this.code,
    required this.description,
    required this.userRoles,
  });

  String code;
  String description;
  List<UserRole> userRoles;

  factory UserRolesModel.fromRawJson(String str) => UserRolesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserRolesModel.fromJson(Map<String, dynamic> json) => UserRolesModel(
        code: json["code"],
        description: json["description"],
        userRoles: List<UserRole>.from(json["userRoles"].map((x) => UserRole.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "userRoles": List<dynamic>.from(userRoles.map((x) => x.toJson())),
      };
}

class UserRole {
  UserRole({
    required this.code,
    required this.name,
  });

  String code;
  Name name;

  factory UserRole.fromRawJson(String str) => UserRole.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        code: json["code"],
        name: Name.fromJson(json["name"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name.toJson(),
      };
}

class Name {
  Name({
    required this.th,
    required this.en,
  });

  String th;
  String en;

  factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        th: json["th"],
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "th": th,
        "en": en,
      };
}
