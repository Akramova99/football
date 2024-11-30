import 'dart:convert';

// JSON ma'lumotlarini parse qilish uchun
// final JoinedTeamModel = leagueModelFromJson(jsonString);

JoinedTeamModel joinedTeamFromJson(String str) =>
    JoinedTeamModel.fromJson(json.decode(str));

String joinedTeamToJson(List<JoinedTeamModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JoinedTeamModel {
  String? leagueId;
  String? leagueName;
  int? totalTeams;
  int? joinedTeams;

  JoinedTeamModel({
    this.leagueId,
    this.leagueName,
    this.totalTeams,
    this.joinedTeams,
  });

  factory JoinedTeamModel.fromJson(Map<String, dynamic> json) => JoinedTeamModel(
    leagueId: json["leagueId"],
    leagueName: json["leagueName"],
    totalTeams: json["totalTeams"],
    joinedTeams: json["joinedTeams"],
  );

  Map<String, dynamic> toJson() => {
    "leagueId": leagueId,
    "leagueName": leagueName,
    "totalTeams": totalTeams,
    "joinedTeams": joinedTeams,
  };
}
