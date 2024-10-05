import 'dart:convert';

List<YearlyPayment> yearlyPaymentsFromJson(String str) =>
    List<YearlyPayment>.from(json.decode(str).map((x) => YearlyPayment.fromJson(x)));


class MonthlyPayment {
  String month;
  double totalAmount;

  MonthlyPayment({
    required this.month,
    required this.totalAmount,
  });

  // Factory method to create a MonthlyPayment from JSON
  factory MonthlyPayment.fromJson(Map<String, dynamic> json) {
    return MonthlyPayment(
      month: json['month'],
      totalAmount: json['totalAmount'].toDouble(),
    );
  }

  // Method to convert a MonthlyPayment to JSON
  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'totalAmount': totalAmount,
    };
  }
}

class YearlyPayment {
  int year;
  List<MonthlyPayment> monthlyPayments;

  YearlyPayment({
    required this.year,
    required this.monthlyPayments,
  });

  // Factory method to create a YearlyPayment from JSON
  factory YearlyPayment.fromJson(Map<String, dynamic> json) {
    return YearlyPayment(
      year: json['year'],
      monthlyPayments: (json['monthlyPayments'] as List)
          .map((item) => MonthlyPayment.fromJson(item))
          .toList(),
    );
  }

  // Method to convert a YearlyPayment to JSON
  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'monthlyPayments': monthlyPayments.map((payment) => payment.toJson()).toList(),
    };
  }
}
