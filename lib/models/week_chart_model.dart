import 'dart:convert';

class MatchScore {
  final int matchWeekNumber;
  final int totalScore;

  MatchScore({
    required this.matchWeekNumber,
    required this.totalScore,
  });

  // JSON'dan Dart obyektiga o'zgartiruvchi funksiya
  factory MatchScore.fromJson(Map<String, dynamic> json) {
    return MatchScore(
      matchWeekNumber: json['matchWeekNumber'],
      totalScore: json['totalScore'],
    );
  }

  // Dart obyektini JSON formatiga o'zgartiruvchi funksiya
  Map<String, dynamic> toJson() {
    return {
      'matchWeekNumber': matchWeekNumber,
      'totalScore': totalScore,
    };
  }
}
List<MatchScore> playerCharts2FromJson(String str) => List<MatchScore>.from(json.decode(str).map((x) => MatchScore.fromJson(x)));

String playerCharts2ModelToJson(List<MatchScore> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
// Natijani chiqarish
// for (var matchScore in matchScores) {
// print("Match Week: ${matchScore.matchWeekNumber}, Total Score: ${matchScore.totalScore}");
// }

// MatchScore obyektlarini JSON formatiga qaytarish
// List<Map<String, dynamic>> jsonData = matchScores.map((matchScore) => matchScore.toJson()).toList();
