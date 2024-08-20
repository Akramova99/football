
// To parse this JSON data, do
//
//     final leagueModel = leagueModelFromJson(jsonString);

import 'dart:convert';

import 'package:football/models/match_model.dart';

import 'matchweek_model.dart';

List<LeagueModel> leagueModelFromJson(String str) => List<LeagueModel>.from(json.decode(str).map((x) => LeagueModel.fromJson(x)));

String leagueModelToJson(List<LeagueModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeagueModel {
  String? id;
  String? name;
  String? description;
  bool? expired;
  DateTime? createdAt;
  String? image;
  MatchweekModel? startWeek;
  MatchweekModel? endWeek;
  String? createdBy;

  LeagueModel({
    this.id,
    this.name,
    this.description,
    this.expired,
    this.createdAt,
    this.image,
    this.startWeek,
    this.endWeek,
    this.createdBy,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) => LeagueModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    expired: json["expired"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    image: json["image"],
    startWeek: json["startWeek"] == null ? null : MatchweekModel.fromJson(json["startWeek"]),
    endWeek: json["endWeek"] == null ? null : MatchweekModel.fromJson(json["endWeek"]),
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "expired": expired,
    "createdAt": createdAt?.toIso8601String(),
    "image": image,
    "startWeek": startWeek?.toJson(),
    "endWeek": endWeek?.toJson(),
    "createdBy": createdBy,
  };
}


