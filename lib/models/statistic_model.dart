import 'dart:convert';

List<StatisticModel> statisticModelFromJson(String str) {
  final json = jsonDecode(str);

  var list =
      List<StatisticModel>.from(json.map((mp) => StatisticModel.fromJson(mp)));
  return list;
}

class StatisticModel {
  int playerId;
  String playerName;
  int playerNumber;
  int playerTotalScore;
  String playerJersey;
  String position;
  String clubName;
  String clubLogo;

  StatisticModel({
    required this.playerId,
    required this.playerName,
    required this.playerNumber,
    required this.playerTotalScore,
    required this.playerJersey,
    required this.position,
    required this.clubName,
    required this.clubLogo,
  });

  factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
    playerId: json['playerId'] ?? 0,
    playerName: json['playerName'] ?? '',
    playerNumber: json['playerNumber'] ?? 0,
    playerTotalScore: json['playerTotalScore'] ?? 0,
    playerJersey: json['playerJersey'] ?? '',
    position: json['position'] ?? '',
    clubName: json['clubName'] ?? '',
    clubLogo: json['clubLogo'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'playerId': playerId,
    'playerName': playerName,
    'playerNumber': playerNumber,
    'playerTotalScore': playerTotalScore,
    'playerJersey': playerJersey,
    'position': position,
    'clubName': clubName,
    'clubLogo': clubLogo,
  };
}

