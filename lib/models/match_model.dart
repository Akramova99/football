// To parse this JSON data, do
//
//     final matchModel = matchModelFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

List<MatchModel> matchModelFromJson(String str) =>
    List<MatchModel>.from(json.decode(str).map((x) => MatchModel.fromJson(x)));

String matchModelToJson(List<MatchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MatchModel {
  int? id;
  Away? home;
  Away? away;
  MatchWeek? matchWeek;
  String? startTime; // Store the time as a string
  DateTime? matchDate;

  MatchModel({
    this.id,
    this.home,
    this.away,
    this.matchWeek,
    this.startTime,
    this.matchDate,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
    id: json["id"],
    home: json["home"] == null ? null : Away.fromJson(json["home"]),
    away: json["away"] == null ? null : Away.fromJson(json["away"]),
    matchWeek: json["matchWeek"] == null
        ? null
        : MatchWeek.fromJson(json["matchWeek"]),
    startTime: json["startTime"] ?? null,
    matchDate: json["matchDate"] == null
        ? null
        : DateTime.parse(json["matchDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "home": home?.toJson(),
    "away": away?.toJson(),
    "matchWeek": matchWeek?.toJson(),
    "startTime": startTime,
    "matchDate": matchDate?.toIso8601String(),
  };
}

DateTime combineDateWithTime(DateTime date, String time) {
  final timeParts = time.split(':');
  return DateTime(
    date.year,
    date.month,
    date.day,
    int.parse(timeParts[0]),
    int.parse(timeParts[1]),
    int.parse(timeParts[2]),
  );
}

class Away {
  int? id;
  String? teamName;
  String? logo;
  String? jersey;

  Away({
    this.id,
    this.teamName,
    this.logo,
    this.jersey,
  });

  factory Away.fromJson(Map<String, dynamic> json) => Away(
        id: json["id"],
        teamName: json["teamName"],
        logo: json["logo"],
        jersey: json["jersey"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teamName": teamName,
        "logo": logo,
        "jersey": jersey,
      };
}

List<MatchWeek> matchWeekFromJson(String str) =>
    List<MatchWeek>.from(json.decode(str).map((x) => MatchWeek.fromJson(x)));
class MatchWeek {
  int? id;
  int? weekNumber;
  DateTime? startDate;
  DateTime? endDate;

  MatchWeek({
    this.id,
    this.weekNumber,
    this.startDate,
    this.endDate,
  });

  factory MatchWeek.fromJson(Map<String, dynamic> json) => MatchWeek(
        id: json["id"],
        weekNumber: json["weekNumber"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "weekNumber": weekNumber,
        "startDate":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "endDate":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
      };
}


