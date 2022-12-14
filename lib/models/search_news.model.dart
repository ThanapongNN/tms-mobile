// To parse this JSON data, do
//
//     final searchNewsModel = searchNewsModelFromJson(jsonString);

import 'dart:convert';

class SearchNewsModel {
  SearchNewsModel({
    required this.code,
    required this.description,
    required this.transactionId,
    required this.data,
  });

  final String code;
  final String description;
  final String transactionId;
  final List<Datum> data;

  factory SearchNewsModel.fromRawJson(String str) => SearchNewsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchNewsModel.fromJson(Map<String, dynamic> json) => SearchNewsModel(
        code: json["code"],
        description: json["description"],
        transactionId: json["transactionId"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "transactionId": transactionId,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.nameTh,
    required this.nameEn,
    required this.sourceType,
    required this.thumbnailUrl,
    required this.headline,
    required this.subHeadline,
    required this.sourceUrl,
    required this.startDate,
    required this.endDate,
  });

  final String nameTh;
  final String nameEn;
  final String sourceType;
  final String thumbnailUrl;
  final String headline;
  final String subHeadline;
  final String sourceUrl;
  final DateTime startDate;
  final DateTime endDate;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        nameTh: json["name_th"],
        nameEn: json["name_en"],
        sourceType: json["source_type"],
        thumbnailUrl: json["thumbnail_url"],
        headline: json["headline"],
        subHeadline: json["sub_headline"],
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
        "sub_headline": subHeadline,
        "source_url": sourceUrl,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
      };
}
