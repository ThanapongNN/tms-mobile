// To parse this JSON data, do
//
//     final productGroupModel = productGroupModelFromJson(jsonString);

import 'dart:convert';

class ProductGroupModel {
  ProductGroupModel({
    this.code,
    this.description,
    this.data,
    this.transactionId,
  });

  String? code;
  String? description;
  List<Datum?>? data;
  String? transactionId;

  factory ProductGroupModel.fromRawJson(String str) => ProductGroupModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductGroupModel.fromJson(Map<String, dynamic> json) => ProductGroupModel(
        code: json["code"],
        description: json["description"],
        data: json["data"] == null ? [] : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        transactionId: json["transactionId"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
        "transactionId": transactionId,
      };
}

class Datum {
  Datum({
    this.lastUpdate,
    this.totalCount,
    this.strDate,
    this.productGroup,
    this.homeDisplay,
    this.commission,
  });

  DateTime? lastUpdate;
  int? totalCount;
  String? strDate;
  List<ProductGroup?>? productGroup;
  List<HomeDisplay?>? homeDisplay;
  List<Commission?>? commission;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        lastUpdate: DateTime.parse(json["lastUpdate"]),
        totalCount: json["totalCount"],
        strDate: json["strDate"],
        productGroup: json["productGroup"] == null ? [] : List<ProductGroup?>.from(json["productGroup"]!.map((x) => ProductGroup.fromJson(x))),
        homeDisplay: json["homeDisplay"] == null ? [] : List<HomeDisplay?>.from(json["homeDisplay"]!.map((x) => HomeDisplay.fromJson(x))),
        commission: json["commission"] == null ? [] : List<Commission?>.from(json["commission"]!.map((x) => Commission.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lastUpdate": lastUpdate?.toIso8601String(),
        "totalCount": totalCount,
        "strDate": strDate,
        "productGroup": productGroup == null ? [] : List<dynamic>.from(productGroup!.map((x) => x!.toJson())),
        "homeDisplay": homeDisplay == null ? [] : List<dynamic>.from(homeDisplay!.map((x) => x!.toJson())),
        "commission": commission == null ? [] : List<dynamic>.from(commission!.map((x) => x!.toJson())),
      };
}

class Commission {
  Commission({
    this.name,
    this.total,
    this.unit,
    this.iconName,
    this.summary,
    this.list,
  });

  String? name;
  int? total;
  String? unit;
  String? iconName;
  String? summary;
  List<ListElement?>? list;

  factory Commission.fromRawJson(String str) => Commission.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Commission.fromJson(Map<String, dynamic> json) => Commission(
        name: json["name"],
        total: json["total"],
        unit: json["unit"],
        iconName: json["iconName"],
        summary: json["summary"],
        list: json["list"] == null ? [] : List<ListElement?>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "total": total,
        "unit": unit,
        "iconName": iconName,
        "summary": summary,
        "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x!.toJson())),
      };
}

class ListElement {
  ListElement({
    this.name,
    this.ea,
    this.unit,
    this.summary,
  });

  String? name;
  int? ea;
  String? unit;
  String? summary;

  factory ListElement.fromRawJson(String str) => ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        name: json["name"],
        ea: json["ea"],
        unit: json["unit"],
        summary: json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "ea": ea,
        "unit": unit,
        "summary": summary,
      };
}

class HomeDisplay {
  HomeDisplay({
    this.order,
    this.orderTotal,
    this.unit,
    this.iconName,
    this.countSum,
    this.commission,
    this.homeSeq,
    this.serviceCampaign,
  });

  String? order;
  int? orderTotal;
  String? unit;
  String? iconName;
  bool? countSum;
  bool? commission;
  int? homeSeq;
  List<dynamic>? serviceCampaign;

  factory HomeDisplay.fromRawJson(String str) => HomeDisplay.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeDisplay.fromJson(Map<String, dynamic> json) => HomeDisplay(
        order: json["order"],
        orderTotal: json["orderTotal"],
        unit: json["unit"],
        iconName: json["iconName"],
        countSum: json["countSum"],
        commission: json["commission"],
        homeSeq: json["homeSeq"],
        serviceCampaign: json["serviceCampaign"] == null ? [] : List<dynamic>.from(json["serviceCampaign"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "orderTotal": orderTotal,
        "unit": unit,
        "iconName": iconName,
        "countSum": countSum,
        "commission": commission,
        "homeSeq": homeSeq,
        "serviceCampaign": serviceCampaign == null ? [] : List<dynamic>.from(serviceCampaign!.map((x) => x)),
      };
}

class ProductGroup {
  ProductGroup({
    this.code,
    this.product,
    this.salesTotal,
    this.iconName,
    this.salesOrder,
  });

  String? code;
  String? product;
  int? salesTotal;
  String? iconName;
  List<HomeDisplay?>? salesOrder;

  factory ProductGroup.fromRawJson(String str) => ProductGroup.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductGroup.fromJson(Map<String, dynamic> json) => ProductGroup(
        code: json["code"],
        product: json["product"],
        salesTotal: json["salesTotal"],
        iconName: json["iconName"],
        salesOrder: json["salesOrder"] == null ? [] : List<HomeDisplay?>.from(json["salesOrder"]!.map((x) => HomeDisplay.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "product": product,
        "salesTotal": salesTotal,
        "iconName": iconName,
        "salesOrder": salesOrder == null ? [] : List<dynamic>.from(salesOrder!.map((x) => x!.toJson())),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
