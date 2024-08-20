import 'dart:convert';

import 'package:football/models/matchweek_model.dart';
import 'package:football/models/team_reyting_model.dart';

LeagueDetailModel leagueDetailModelFromJson(String str) => LeagueDetailModel.fromJson(json.decode(str));

String leagueDetailModelToJson(LeagueDetailModel data) => json.encode(data.toJson());

class LeagueDetailModel {
  String? id;
  String? name;
  List<TeamRatingModel>? teams;
  String? description;
  bool? expired;
  DateTime? createdAt;
  String? image;
  MatchweekModel? startWeek;
  MatchweekModel? endWeek;
  String? createdBy;

  LeagueDetailModel({
    this.id,
    this.name,
    this.teams,
    this.description,
    this.expired,
    this.createdAt,
    this.image,
    this.startWeek,
    this.endWeek,
    this.createdBy,
  });

  factory LeagueDetailModel.fromJson(Map<String, dynamic> json) => LeagueDetailModel(
    id: json["id"],
    name: json["name"],
    teams: json["teams"] == null ? [] : List<TeamRatingModel>.from(json["teams"]!.map((x) => TeamRatingModel.fromJson(x))),
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
    "teams": teams == null ? [] : List<dynamic>.from(teams!.map((x) => x.toJson())),
    "description": description,
    "expired": expired,
    "createdAt": createdAt?.toIso8601String(),
    "image": image,
    "startWeek": startWeek?.toJson(),
    "endWeek": endWeek?.toJson(),
    "createdBy": createdBy,
  };
}