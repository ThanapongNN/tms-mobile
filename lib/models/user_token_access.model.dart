// To parse this JSON data, do
//
//     final userTokenAccessModel = userTokenAccessModelFromJson(jsonString);

import 'dart:convert';

class UserTokenAccessModel {
  UserTokenAccessModel({
    required this.code,
    required this.description,
    required this.transactionId,
    required this.token,
  });

  String code;
  String description;
  String transactionId;
  String token;

  factory UserTokenAccessModel.fromRawJson(String str) => UserTokenAccessModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserTokenAccessModel.fromJson(Map<String, dynamic> json) => UserTokenAccessModel(
        code: json["code"],
        description: json["description"],
        transactionId: json["transactionId"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "transactionId": transactionId,
        "token": token,
      };
}
