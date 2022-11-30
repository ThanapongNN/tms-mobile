// To parse this JSON data, do
//
//     final productGroupModel = productGroupModelFromJson(jsonString);

import 'dart:convert';

class ProductGroupModel {
  ProductGroupModel({
    required this.code,
    required this.description,
    required this.data,
  });

  final String code;
  final String description;
  final List<Datum> data;

  factory ProductGroupModel.fromRawJson(String str) => ProductGroupModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductGroupModel.fromJson(Map<String, dynamic> json) => ProductGroupModel(
        code: json["code"],
        description: json["description"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.lastUpdate,
    required this.totalCount,
    required this.strDate,
    required this.productGroup,
  });

  final DateTime lastUpdate;
  final int totalCount;
  final String strDate;
  final List<ProductGroup> productGroup;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        lastUpdate: DateTime.parse(json["lastUpdate"]),
        totalCount: json["totalCount"],
        strDate: json["strDate"],
        productGroup: List<ProductGroup>.from(json["productGroup"].map((x) => ProductGroup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lastUpdate": lastUpdate.toIso8601String(),
        "totalCount": totalCount,
        "strDate": strDate,
        "productGroup": List<dynamic>.from(productGroup.map((x) => x.toJson())),
      };
}

class ProductGroup {
  ProductGroup({
    required this.code,
    required this.product,
    required this.salesTotal,
    required this.salesOrder,
  });

  final String code;
  final String product;
  final int salesTotal;
  final List<SalesOrder> salesOrder;

  factory ProductGroup.fromRawJson(String str) => ProductGroup.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductGroup.fromJson(Map<String, dynamic> json) => ProductGroup(
        code: json["code"],
        product: json["product"],
        salesTotal: json["salesTotal"],
        salesOrder: List<SalesOrder>.from(json["salesOrder"].map((x) => SalesOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "product": product,
        "salesTotal": salesTotal,
        "salesOrder": List<dynamic>.from(salesOrder.map((x) => x.toJson())),
      };
}

class SalesOrder {
  SalesOrder({
    required this.order,
    required this.orderTotal,
    required this.unit,
    required this.serviceCampaign,
  });

  final String order;
  final int orderTotal;
  final String unit;
  final List<ServiceCampaign> serviceCampaign;

  factory SalesOrder.fromRawJson(String str) => SalesOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
        order: json["order"],
        orderTotal: json["orderTotal"],
        unit: json["unit"],
        serviceCampaign: List<ServiceCampaign>.from(json["serviceCampaign"].map((x) => ServiceCampaign.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "orderTotal": orderTotal,
        "unit": unit,
        "serviceCampaign": List<dynamic>.from(serviceCampaign.map((x) => x.toJson())),
      };
}

class ServiceCampaign {
  ServiceCampaign({
    required this.name,
    required this.ea,
    required this.unit,
  });

  final String name;
  final int ea;
  final String unit;

  factory ServiceCampaign.fromRawJson(String str) => ServiceCampaign.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceCampaign.fromJson(Map<String, dynamic> json) => ServiceCampaign(
        name: json["name"],
        ea: json["ea"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "ea": ea,
        "unit": unit,
      };
}
