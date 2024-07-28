// To parse this JSON data, do
//
//     final playerModel = playerModelFromJson(jsonString);

import 'dart:convert';

List<PlayerSelectionModel> playerModelFromJson(String str) => List<PlayerSelectionModel>.from(json.decode(str).map((x) => PlayerSelectionModel.fromJson(x)));

String playerModelToJson(List<PlayerSelectionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlayerSelectionModel {
  int? id;
  String? name;
  String? position;
  dynamic playerNumber;
  String? clubName;
  double? price;
  int? currentScore;
  int? score;
  dynamic jersey;

  PlayerSelectionModel({
    this.id,
    this.name,
    this.position,
    this.playerNumber,
    this.clubName,
    this.price,
    this.currentScore,
    this.score,
    this.jersey,
  });

  factory PlayerSelectionModel.fromJson(Map<String, dynamic> json) => PlayerSelectionModel(
    id: json["id"],
    name: json["name"],
    position: json["position"],
    playerNumber: json["playerNumber"],
    clubName: json["clubName"],
    price: json["price"]?.toDouble(),
    currentScore: json["currentScore"],
    score: json["score"],
    jersey: json["jersey"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "position": position,
    "playerNumber": playerNumber,
    "clubName": clubName,
    "price": price,
    "currentScore": currentScore,
    "score": score,
    "jersey": jersey,
  };
}
