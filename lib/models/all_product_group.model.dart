// To parse this JSON data, do
//
//     final allProductGroupModel = allProductGroupModelFromJson(jsonString);

import 'dart:convert';

class AllProductGroupModel {
    AllProductGroupModel({
        required this.allProductGroup,
    });

    List<AllProductGroup> allProductGroup;

    factory AllProductGroupModel.fromRawJson(String str) => AllProductGroupModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllProductGroupModel.fromJson(Map<String, dynamic> json) => AllProductGroupModel(
        allProductGroup: List<AllProductGroup>.from(json["allProductGroup"].map((x) => AllProductGroup.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "allProductGroup": List<dynamic>.from(allProductGroup.map((x) => x.toJson())),
    };
}

class AllProductGroup {
    AllProductGroup({
        required this.icon,
        required this.order,
        required this.orderTotal,
        required this.unit,
        required this.serviceCampaign,
    });

    String icon;
    String order;
    String orderTotal;
    String unit;
    List<ServiceCampaign> serviceCampaign;

    factory AllProductGroup.fromRawJson(String str) => AllProductGroup.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllProductGroup.fromJson(Map<String, dynamic> json) => AllProductGroup(
        icon: json["icon"],
        order: json["order"],
        orderTotal: json["orderTotal"],
        unit: json["unit"],
        serviceCampaign: List<ServiceCampaign>.from(json["serviceCampaign"].map((x) => ServiceCampaign.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "icon": icon,
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

    String name;
    String ea;
    String unit;

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


