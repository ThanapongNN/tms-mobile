// To parse this JSON data, do
//
//     final productGroupModel = productGroupModelFromJson(jsonString);

import 'dart:convert';

class ProductGroupModel {
  ProductGroupModel({
    required this.code,
    required this.description,
    required this.transactionId,
    required this.data,
  });

  final String code;
  final String description;
  final String transactionId;
  final List<Datum> data;

  factory ProductGroupModel.fromRawJson(String str) => ProductGroupModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductGroupModel.fromJson(Map<String, dynamic> json) => ProductGroupModel(
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
    required this.lastUpdate,
    required this.totalCount,
    required this.strDate,
    required this.productGroup,
    required this.reward,
  });

  final DateTime lastUpdate;
  final int totalCount;
  final String strDate;
  final List<ProductGroup> productGroup;
  final List<Reward> reward;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        lastUpdate: DateTime.parse(json["lastUpdate"]),
        totalCount: json["totalCount"],
        strDate: json["strDate"],
        productGroup: List<ProductGroup>.from(json["productGroup"].map((x) => ProductGroup.fromJson(x))),
        reward: List<Reward>.from(json["reward"].map((x) => Reward.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lastUpdate": lastUpdate.toIso8601String(),
        "totalCount": totalCount,
        "strDate": strDate,
        "productGroup": List<dynamic>.from(productGroup.map((x) => x.toJson())),
        "reward": List<dynamic>.from(reward.map((x) => x.toJson())),
      };
}

class ProductGroup {
  ProductGroup({
    required this.code,
    required this.product,
    required this.salesTotal,
    required this.iconName,
    required this.salesOrder,
  });

  final String code;
  final String product;
  final int salesTotal;
  final String iconName;
  final List<SalesOrder> salesOrder;

  factory ProductGroup.fromRawJson(String str) => ProductGroup.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductGroup.fromJson(Map<String, dynamic> json) => ProductGroup(
        code: json["code"],
        product: json["product"],
        salesTotal: json["salesTotal"],
        iconName: json["iconName"],
        salesOrder: List<SalesOrder>.from(json["salesOrder"].map((x) => SalesOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "product": product,
        "salesTotal": salesTotal,
        "iconName": iconName,
        "salesOrder": List<dynamic>.from(salesOrder.map((x) => x.toJson())),
      };
}

class SalesOrder {
  SalesOrder({
    required this.order,
    required this.orderTotal,
    required this.unit,
    required this.iconName,
    required this.serviceCampaign,
  });

  final String order;
  final int orderTotal;
  final String unit;
  final String iconName;
  final List<ListElement> serviceCampaign;

  factory SalesOrder.fromRawJson(String str) => SalesOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
        order: json["order"],
        orderTotal: json["orderTotal"],
        unit: json["unit"],
        iconName: json["iconName"],
        serviceCampaign: List<ListElement>.from(json["serviceCampaign"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "orderTotal": orderTotal,
        "unit": unit,
        "iconName": iconName,
        "serviceCampaign": List<dynamic>.from(serviceCampaign.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    required this.name,
    required this.ea,
    required this.unit,
    required this.summary,
  });

  final String name;
  final int ea;
  final String unit;
  final String summary;

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

class Reward {
  Reward({
    required this.name,
    required this.total,
    required this.iconName,
    required this.summary,
    required this.list,
    required this.unit,
  });

  final String name;
  final int total;
  final String iconName;
  final String summary;
  final List<ListElement> list;
  final String unit;

  factory Reward.fromRawJson(String str) => Reward.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        name: json["name"],
        total: json["total"],
        iconName: json["iconName"],
        summary: json["summary"],
        list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "total": total,
        "iconName": iconName,
        "summary": summary,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "unit": unit,
      };
}
