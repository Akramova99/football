import 'dart:convert';

List<PaymentHistory> paymentHistoryModelFromJson(String str) => List<PaymentHistory>.from(json.decode(str).map((x) => PaymentHistory.fromJson(x)));


class   PaymentHistory {
  PaymentHistory({
    required this.id,
    required this.paycomId,
    required this.amount,
    required this.coinAmount,
    required this.delivered,
    required this.paymentMethod,
    required this.createdDate,
  });

  final int? id;
  final String? paycomId;
  final int? amount;
  final int? coinAmount;
  final bool? delivered;
  final String? paymentMethod;
  final DateTime? createdDate;

  factory PaymentHistory.fromJson(Map<String, dynamic> json){
    return PaymentHistory(
      id: json["id"],
      paycomId: json["paycomId"],
      amount: json["amount"],
      coinAmount: json["coinAmount"],
      delivered: json["delivered"],
      paymentMethod: json["paymentMethod"],
      createdDate: DateTime.tryParse(json["createdDate"] ?? ""),
    );
  }

}
