// To parse this JSON data, do
//
//     final matchweekModel = matchweekModelFromJson(jsonString);

import 'dart:convert';

List<MatchweekModel> matchweekModelFromJson(String str) => List<MatchweekModel>.from(json.decode(str).map((x) => MatchweekModel.fromJson(x)));

String matchweekModelToJson(List<MatchweekModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MatchweekModel {
  int? id;
  int? weekNumber;
  DateTime? startDate;
  DateTime? endDate;

  MatchweekModel({
    this.id,
    this.weekNumber,
    this.startDate,
    this.endDate,
  });

  factory MatchweekModel.fromJson(Map<String, dynamic> json) => MatchweekModel(
    id: json["id"],
    weekNumber: json["weekNumber"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "weekNumber": weekNumber,
    "startDate": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "endDate": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
  };
}
