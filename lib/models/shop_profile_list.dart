// To parse this JSON data, do
//
//     final shopProfileList = shopProfileListFromJson(jsonString);

import 'dart:convert';

class ShopProfileList {
  ShopProfileList({
    required this.statusCode,
    required this.statusDesc,
    required this.shopProfileList,
  });

  String statusCode;
  String statusDesc;
  List<ShopProfileListElement> shopProfileList;

  factory ShopProfileList.fromRawJson(String str) => ShopProfileList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShopProfileList.fromJson(Map<String, dynamic> json) => ShopProfileList(
        statusCode: json["statusCode"],
        statusDesc: json["statusDesc"],
        shopProfileList: List<ShopProfileListElement>.from(json["shopProfileList"].map((x) => ShopProfileListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "statusDesc": statusDesc,
        "shopProfileList": List<dynamic>.from(shopProfileList.map((x) => x.toJson())),
      };
}

class ShopProfileListElement {
  ShopProfileListElement({
    required this.partnerCode,
    required this.partnerTypeId,
    required this.partnerTypeName,
    required this.partnerNameEn,
    required this.partnerNameTh,
    required this.shopNameEn,
    required this.shopNameTh,
    required this.channelAlias,
    required this.channelName,
    required this.latitude,
    required this.longitude,
  });

  String partnerCode;
  String partnerTypeId;
  String partnerTypeName;
  String partnerNameEn;
  String partnerNameTh;
  String shopNameEn;
  String shopNameTh;
  String channelAlias;
  String channelName;
  String latitude;
  String longitude;

  factory ShopProfileListElement.fromRawJson(String str) => ShopProfileListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShopProfileListElement.fromJson(Map<String, dynamic> json) => ShopProfileListElement(
        partnerCode: json["partnerCode"],
        partnerTypeId: json["partnerTypeId"],
        partnerTypeName: json["partnerTypeName"],
        partnerNameEn: json["partnerNameEn"],
        partnerNameTh: json["partnerNameTh"],
        shopNameEn: json["shopNameEn"],
        shopNameTh: json["shopNameTh"],
        channelAlias: json["channelAlias"],
        channelName: json["channelName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "partnerTypeId": partnerTypeId,
        "partnerTypeName": partnerTypeName,
        "partnerNameEn": partnerNameEn,
        "partnerNameTh": partnerNameTh,
        "shopNameEn": shopNameEn,
        "shopNameTh": shopNameTh,
        "channelAlias": channelAlias,
        "channelName": channelName,
        "latitude": latitude,
        "longitude": longitude,
      };
}
