// To parse this JSON data, do
//
//     final clubModel = clubModelFromJson(jsonString);

import 'dart:convert';

List<ClubModel> clubModelFromJson(String str) => List<ClubModel>.from(json.decode(str).map((x) => ClubModel.fromJson(x)));

String clubModelToJson(List<ClubModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClubModel {
  int? id;
  String? teamName;
  String? logo;
  String? jersey;
  String? goalKeeperJersey;

  ClubModel({
    this.id,
    this.teamName,
    this.logo,
    this.jersey,
    this.goalKeeperJersey,
  });

  factory ClubModel.fromJson(Map<String, dynamic> json) => ClubModel(
    id: json["id"],
    teamName: json["teamName"],
    logo: json["logo"],
    jersey: json["jersey"],
    goalKeeperJersey: json["goalKeeperJersey"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "teamName": teamName,
    "logo": logo,
    "jersey": jersey,
    "goalKeeperJersey": goalKeeperJersey,
  };
}
