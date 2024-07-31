import 'dart:convert';

List<TeamNamesModel> teamNamesModelFromJson(String str) =>
    List<TeamNamesModel>.from(
        json.decode(str).map((x) => TeamNamesModel.fromJson(x)));

String teamNamesModelToJson(List<TeamNamesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamNamesModel {
  int? id;
  String? name;
  String? logo;

  TeamNamesModel({
    this.id,
    this.name,
    this.logo,
  });

  factory TeamNamesModel.fromJson(Map<String, dynamic> json) => TeamNamesModel(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
      };
}
