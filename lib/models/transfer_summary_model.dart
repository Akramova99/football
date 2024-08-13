// To parse this JSON data, do
//
//     final transferSummaryModel = transferSummaryModelFromJson(jsonString);

import 'dart:convert';

TransferSummaryModel transferSummaryModelFromJson(String str) => TransferSummaryModel.fromJson(json.decode(str));

String transferSummaryModelToJson(TransferSummaryModel data) => json.encode(data.toJson());

class TransferSummaryModel {
  double? balance;
  int? selectionLimit;
  int? freeTransfers;
  int? paidTransfers;

  TransferSummaryModel({
    this.balance,
    this.selectionLimit,
    this.freeTransfers,
    this.paidTransfers,
  });

  factory TransferSummaryModel.fromJson(Map<String, dynamic> json) => TransferSummaryModel(
    balance: json["balance"],
    selectionLimit: json["selectionLimit"],
    freeTransfers: json["freeTransfers"],
    paidTransfers: json["paidTransfers"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "selectionLimit": selectionLimit,
    "freeTransfers": freeTransfers,
    "paidTransfers": paidTransfers,
  };
}
