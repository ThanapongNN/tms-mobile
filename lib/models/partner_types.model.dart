// To parse this JSON data, do
//
//     final partnerTypesModel = partnerTypesModelFromJson(jsonString);

import 'dart:convert';

class PartnerTypesModel {
  PartnerTypesModel({
    required this.code,
    required this.description,
    required this.partnerTypes,
  });

  String code;
  String description;
  List<PartnerType> partnerTypes;

  factory PartnerTypesModel.fromRawJson(String str) => PartnerTypesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PartnerTypesModel.fromJson(Map<String, dynamic> json) => PartnerTypesModel(
        code: json["code"],
        description: json["description"],
        partnerTypes: List<PartnerType>.from(json["partnerTypes"].map((x) => PartnerType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "partnerTypes": List<dynamic>.from(partnerTypes.map((x) => x.toJson())),
      };
}

class PartnerType {
  PartnerType({
    required this.code,
    required this.name,
    this.dmsAppChannel,
  });

  String code;
  Name name;
  dynamic dmsAppChannel;

  factory PartnerType.fromRawJson(String str) => PartnerType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PartnerType.fromJson(Map<String, dynamic> json) => PartnerType(
        code: json["code"],
        name: Name.fromJson(json["name"]),
        dmsAppChannel: json["dmsAppChannel"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name.toJson(),
        "dmsAppChannel": dmsAppChannel,
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
