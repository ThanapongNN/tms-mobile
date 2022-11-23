// To parse this JSON data, do
//
//     final productGroupModel = productGroupModelFromJson(jsonString);

import 'dart:convert';

class ProductGroupModel {
  ProductGroupModel({
    required this.code,
    required this.description,
    required this.lastUpdate,
    required this.productGroup,
  });

  String code;
  String description;
  DateTime lastUpdate;
  List<ProductGroup> productGroup;

  factory ProductGroupModel.fromRawJson(String str) => ProductGroupModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductGroupModel.fromJson(Map<String, dynamic> json) => ProductGroupModel(
        code: json["code"],
        description: json["description"],
        lastUpdate: DateTime.parse(json["lastUpdate"]),
        productGroup: List<ProductGroup>.from(json["productGroup"].map((x) => ProductGroup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "lastUpdate": lastUpdate.toIso8601String(),
        "productGroup": List<dynamic>.from(productGroup.map((x) => x.toJson())),
      };
}

class ProductGroup {
  ProductGroup({
    required this.code,
    required this.product,
    required this.salesTotle,
    required this.salesOrder,
    required this.unit,
  });

  String code;
  String product;
  String salesTotle;
  List<SalesOrder> salesOrder;
  String unit;

  factory ProductGroup.fromRawJson(String str) => ProductGroup.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductGroup.fromJson(Map<String, dynamic> json) => ProductGroup(
        code: json["code"],
        product: json["product"],
        salesTotle: json["salesTotle"],
        salesOrder: List<SalesOrder>.from(json["salesOrder"].map((x) => SalesOrder.fromJson(x))),
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "product": product,
        "salesTotle": salesTotle,
        "salesOrder": List<dynamic>.from(salesOrder.map((x) => x.toJson())),
        "unit": unit,
      };
}

class SalesOrder {
  SalesOrder({
    required this.order,
    required this.serviceCampaign,
  });

  String order;
  List<ServiceCampaign> serviceCampaign;

  factory SalesOrder.fromRawJson(String str) => SalesOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
        order: json["order"],
        serviceCampaign: List<ServiceCampaign>.from(json["serviceCampaign"].map((x) => ServiceCampaign.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "serviceCampaign": List<dynamic>.from(serviceCampaign.map((x) => x.toJson())),
      };
}

class ServiceCampaign {
  ServiceCampaign({
    required this.name,
    required this.ea,
  });

  String name;
  String ea;

  factory ServiceCampaign.fromRawJson(String str) => ServiceCampaign.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServiceCampaign.fromJson(Map<String, dynamic> json) => ServiceCampaign(
        name: json["name"],
        ea: json["ea"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "ea": ea,
      };
}
