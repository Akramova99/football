// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? username;
  String? email;
  String? image;
  String? role;
  double? balance;
  int? coins;
  Team? team;
  DateTime? joinedDate;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.image,
    this.role,
    this.balance,
    this.coins,
    this.team,
    this.joinedDate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    image: json["image"],
    role: json["role"],
    balance: json["balance"],
    coins: json["coins"],
    team: json["team"] == null ? null : Team.fromJson(json["team"]),
    joinedDate: json["joinedDate"] == null
        ? null
        : DateTime.parse(json["joinedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "image": image,
    "role": role,
    "balance": balance,
    "coins": coins,
    "team": team?.toJson(),
    "joinedDate": joinedDate?.toIso8601String(),
  };
}

class Team {
  int? id;
  String? name;
  int? totalScore;
  int? currentScore;

  Team({
    this.id,
    this.name,
    this.totalScore,
    this.currentScore,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    name: json["name"],
    totalScore: json["totalScore"],
    currentScore: json["currentScore"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "totalScore": totalScore,
    "currentScore": currentScore,
  };
}
