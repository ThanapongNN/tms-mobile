// To parse this JSON data, do
//
//     final searchNewsModel = searchNewsModelFromJson(jsonString);

import 'dart:convert';

class SearchNewsModel {
  SearchNewsModel({
    this.code,
    this.description,
    this.transactionId,
    this.data,
  });

  String? code;
  String? description;
  String? transactionId;
  List<Datum?>? data;

  factory SearchNewsModel.fromRawJson(String str) => SearchNewsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchNewsModel.fromJson(Map<String, dynamic> json) => SearchNewsModel(
        code: json["code"],
        description: json["description"],
        transactionId: json["transactionId"],
        data: json["data"] == null ? [] : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "transactionId": transactionId,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
      };
}

class Datum {
  Datum({
    this.groupName,
    this.nameTh,
    this.nameEn,
    this.icon,
    this.lists,
  });

  String? groupName;
  String? nameTh;
  String? nameEn;
  String? icon;
  List<ListElement?>? lists;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        groupName: json["group_name"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
        icon: json["icon"],
        lists: json["lists"] == null ? [] : List<ListElement?>.from(json["lists"]!.map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "group_name": groupName,
        "name_th": nameTh,
        "name_en": nameEn,
        "icon": icon,
        "lists": lists == null ? [] : List<dynamic>.from(lists!.map((x) => x!.toJson())),
      };
}

class ListElement {
  ListElement({
    this.nameTh,
    this.nameEn,
    this.sourceType,
    this.thumbnailUrl,
    this.headline,
    this.sourceUrl,
    this.startDate,
    this.endDate,
  });

  String? nameTh;
  String? nameEn;
  String? sourceType;
  String? thumbnailUrl;
  String? headline;
  String? sourceUrl;
  DateTime? startDate;
  DateTime? endDate;

  factory ListElement.fromRawJson(String str) => ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        nameTh: json["name_th"],
        nameEn: json["name_en"],
        sourceType: json["source_type"],
        thumbnailUrl: json["thumbnail_url"],
        headline: json["headline"],
        sourceUrl: json["source_url"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "name_th": nameTh,
        "name_en": nameEn,
        "source_type": sourceType,
        "thumbnail_url": thumbnailUrl,
        "headline": headline,
        "source_url": sourceUrl,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
      };
}
