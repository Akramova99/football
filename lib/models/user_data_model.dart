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
  Team? team;
  DateTime? joinedDate;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.image,
    this.role,
    this.balance,
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
        "team": team?.toJson(),
        "joinedDate": joinedDate?.toIso8601String(),
      };
}

class Team {
  int? id;
  String? name;
  int? totalScore;

  Team({
    this.id,
    this.name,
    this.totalScore,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        totalScore: json["totalScore"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "totalScore": totalScore,
      };
}
