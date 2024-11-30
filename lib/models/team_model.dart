// To parse this JSON data, do
//
//     final teamModel = teamModelFromJson(jsonString);

import 'dart:convert';

TeamModel teamModelFromJson(String str) => TeamModel.fromJson(json.decode(str));

String teamModelToJson(TeamModel data) => json.encode(data.toJson());
List<Player> playerProfileFromJson(String str) =>
    List<Player>.from(
        json.decode(str).map((x) => Player.fromJson(x)));
class TeamModel {
  int? id;
  String? name;
  List<Player>? players;
  int? totalScore;
  dynamic logo;
  dynamic tactic;

  TeamModel({
    this.id,
    this.name,
    this.players,
    this.totalScore,
    this.logo,
    this.tactic,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
    id: json["id"],
    name: json["name"],
    players: json["players"] == null ? [] : List<Player>.from(json["players"]!.map((x) => Player.fromJson(x))),
    totalScore: json["totalScore"],
    logo: json["logo"],
    tactic: json["tactic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "players": players == null ? [] : List<dynamic>.from(players!.map((x) => x.toJson())),
    "totalScore": totalScore,
    "logo": logo,
    "tactic": tactic,
  };
}



class Player {
  int? playerNumber;
  int? id;
  String? name;
  String? position;
  String? clubName;
  String? clubLogo;
  String? jersey;
  int? totalScore;
  double? price;
  bool? isCapitan;
  bool? isPrimary;
  dynamic fineCard;
  int? currentScore;

  Player({
    this.playerNumber,
    this.id,
    this.name,
    this.position,
    this.clubName,
    this.clubLogo,
    this.jersey,
    this.totalScore,
    this.price,
    this.isCapitan,
    this.isPrimary,
    this.fineCard,
    this.currentScore,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    playerNumber: json["player_number"],
    id: json["id"],
    name: json["name"],
    position: json["position"],
    clubName: json["clubName"],
    clubLogo: json["clubLogo"],
    jersey: json["jersey"],
    totalScore: json["totalScore"],
    price: json["price"]?.toDouble(),
    isCapitan: json["isCapitan"],
    isPrimary: json["isPrimary"],
    fineCard: json["fineCard"],
    currentScore: json["currentScore"],
  );

  Map<String, dynamic> toJson() => {
    "player_number": playerNumber,
    "id": id,
    "name": name,
    "position": position,
    "clubName": clubName,
    "clubLogo": clubLogo,
    "jersey": jersey,
    "totalScore": totalScore,
    "price": price,
    "isCapitan": isCapitan,
    "isPrimary": isPrimary,
    "fineCard": fineCard,
    "currentScore": currentScore,
  };
}