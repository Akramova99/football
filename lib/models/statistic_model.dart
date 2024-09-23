import 'dart:convert';

List<StatisticModel> statisticModelFromJson(String str) {
  final json = jsonDecode(str);

  var list =
      List<StatisticModel>.from(json.map((mp) => StatisticModel.fromJson(mp)));
  return list;
}

class StatisticModel {
  int? playerId;
  String playerName;
  int? playerNumber;
  String position;
  String clubName;
  String clubLogo;

  StatisticModel({
    this.playerId,
    required this.playerName,
    this.playerNumber,
    required this.position,
    required this.clubName,
    required this.clubLogo,
  });

  factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
    playerId: json['playerId'] ?? 0, // Provide a default value or make it nullable
    playerName: json['playerName'] ?? '',
    playerNumber: json['playerNumber'] ?? 0, // Provide a default value or make it nullable
    position: json['position'] ?? '',
    clubName: json['clubName'] ?? '',
    clubLogo: json['clubLogo'] ?? '',
  );
}


enum ClubName { LIVERPOOL }

enum Position { DEFENDER, FORWARD, GOALKEEPER, MIDFIELDER }
