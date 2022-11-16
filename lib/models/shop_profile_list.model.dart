// // To parse this JSON data, do
// //
// //     final shopProfileListModel = shopProfileListModelFromJson(jsonString);

// import 'dart:convert';

// class ShopProfileListModel {
//   ShopProfileListModel({
//     required this.code,
//     required this.description,
//     required this.partner,
//   });

//   String code;
//   String description;
//   Partner partner;

//   factory ShopProfileListModel.fromRawJson(String str) => ShopProfileListModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ShopProfileListModel.fromJson(Map<String, dynamic> json) => ShopProfileListModel(
//         code: json["code"],
//         description: json["description"],
//         partner: Partner.fromJson(json["partner"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "description": description,
//         "partner": partner.toJson(),
//       };
// }

// class Partner {
//   Partner({
//     required this.code,
//     required this.name,
//   });

//   String code;
//   Name name;

//   factory Partner.fromRawJson(String str) => Partner.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Partner.fromJson(Map<String, dynamic> json) => Partner(
//         code: json["code"],
//         name: Name.fromJson(json["name"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "name": name.toJson(),
//       };
// }

// class Name {
//   Name({
//     required this.th,
//     required this.en,
//   });

//   String th;
//   String en;

//   factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Name.fromJson(Map<String, dynamic> json) => Name(
//         th: json["th"],
//         en: json["en"],
//       );

//   Map<String, dynamic> toJson() => {
//         "th": th,
//         "en": en,
//       };
// }

// To parse this JSON data, do
//
//     final shopProfileListModel = shopProfileListModelFromJson(jsonString);

import 'dart:convert';

class ShopProfileListModel {
  ShopProfileListModel({
    required this.code,
    required this.description,
    required this.partner,
  });

  String code;
  String description;
  List<Partner> partner;

  factory ShopProfileListModel.fromRawJson(String str) => ShopProfileListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShopProfileListModel.fromJson(Map<String, dynamic> json) => ShopProfileListModel(
        code: json["code"],
        description: json["description"],
        partner: List<Partner>.from(json["partner"].map((x) => Partner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "partner": List<dynamic>.from(partner.map((x) => x.toJson())),
      };
}

class Partner {
  Partner({
    required this.code,
    required this.name,
  });

  String code;
  Name name;

  factory Partner.fromRawJson(String str) => Partner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Partner.fromJson(Map<String, dynamic> json) => Partner(
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
