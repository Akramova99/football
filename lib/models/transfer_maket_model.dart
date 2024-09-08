// To parse this JSON data, do
//
//     final transferPacketModel = transferPacketModelFromJson(jsonString);

import 'dart:convert';

List<TransferPacketModel> transferPacketModelFromJson(String str) => List<TransferPacketModel>.from(json.decode(str).map((x) => TransferPacketModel.fromJson(x)));

String transferPacketModelToJson(List<TransferPacketModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferPacketModel {
  String? name;
  int? coinValue;
  int? cost;
  int? numberOfTransfers;

  TransferPacketModel({
    this.name,
    this.coinValue,
    this.cost,
    this.numberOfTransfers,
  });

  factory TransferPacketModel.fromJson(Map<String, dynamic> json) => TransferPacketModel(
    name: json["name"],
    coinValue: json["coinValue"],
    cost: json["cost"],
    numberOfTransfers: json["numberOfTransfers"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "coinValue": coinValue,
    "cost": cost,
    "numberOfTransfers": numberOfTransfers,
  };
}


