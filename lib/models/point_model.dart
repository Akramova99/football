// To parse this JSON data, do
//
//     final pointModel = pointModelFromJson(jsonString);

import 'dart:convert';

PointModel pointModelFromJson(String str) =>
    PointModel.fromJson(json.decode(str));

String pointModelToJson(PointModel data) => json.encode(data.toJson());

class PointModel {
  int? maxScore;
  int? avgScore;

  PointModel({
    this.maxScore,
    this.avgScore,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) => PointModel(
        maxScore: json["maxScore"],
        avgScore: json["avgScore"],
      );

  Map<String, dynamic> toJson() => {
        "maxScore": maxScore,
        "avgScore": avgScore,
      };
}
