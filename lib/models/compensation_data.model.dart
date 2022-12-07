// To parse this JSON data, do
//
//     final compensationData = compensationDataFromJson(jsonString);

import 'dart:convert';

class CompensationData {
  CompensationData({
    required this.data,
  });

  List<Datum> data;

  factory CompensationData.fromRawJson(String str) => CompensationData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CompensationData.fromJson(Map<String, dynamic> json) => CompensationData(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.code,
    required this.product,
    required this.salesTotal,
    required this.unit,
    required this.iconName,
    required this.salesOrder,
    required this.sum,
  });

  String code;
  String product;
  int salesTotal;
  String unit;
  String iconName;
  List<SalesOrder> salesOrder;
  int sum;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        code: json["code"],
        product: json["product"],
        salesTotal: json["salesTotal"],
        unit: json["unit"],
        iconName: json["iconName"],
        salesOrder: List<SalesOrder>.from(json["salesOrder"].map((x) => SalesOrder.fromJson(x))),
        sum: json["sum"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "product": product,
        "salesTotal": salesTotal,
        "unit": unit,
        "iconName": iconName,
        "salesOrder": List<dynamic>.from(salesOrder.map((x) => x.toJson())),
        "sum": sum,
      };
}

class SalesOrder {
  SalesOrder({
    required this.name,
    required this.ea,
    required this.unit,
    required this.total,
  });

  String name;
  int ea;
  String unit;
  String total;

  factory SalesOrder.fromRawJson(String str) => SalesOrder.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
        name: json["name"],
        ea: json["ea"],
        unit: json["unit"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "ea": ea,
        "unit": unit,
        "total": total,
      };
}
