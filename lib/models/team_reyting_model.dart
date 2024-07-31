import 'dart:convert';

List<TeamRatingModel> teamRatingModelFromJson(String str) => List<TeamRatingModel>.from(json.decode(str).map((x) => TeamRatingModel.fromJson(x)));

String teamRatingModelToJson(List<TeamRatingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamRatingModel {
  int? id;
  String? name;
  int? totalScore;
  int? currentScore;
  String? logo;

  TeamRatingModel({
    this.id,
    this.name,
    this.totalScore,
    this.currentScore,
    this.logo,
  });

  factory TeamRatingModel.fromJson(Map<String, dynamic> json) => TeamRatingModel(
    id: json["id"],
    name: json["name"],
    totalScore: json["totalScore"],
    currentScore: json["currentScore"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "totalScore": totalScore,
    "currentScore": currentScore,
    "logo": logo,
  };
}
