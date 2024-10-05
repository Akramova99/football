
import 'dart:convert';

List<Team> standingModelFromJson(String str) =>
    List<Team>.from(
        json.decode(str).map((x) => Team.fromJson(x)));
class Team {
  final String countryName;
  final String leagueId;
  final String leagueName;
  final String teamId;
  final String teamName;
  final String overallPromotion;
  final String overallLeaguePosition;
  final String overallLeaguePlayed;
  final String overallLeagueW;
  final String overallLeagueD;
  final String overallLeagueL;
  final String overallLeagueGF;
  final String overallLeagueGA;
  final String overallLeaguePTS;
  final String teamBadge;
  final String stageName;

  Team({
    required this.countryName,
    required this.leagueId,
    required this.leagueName,
    required this.teamId,
    required this.teamName,
    required this.overallPromotion,
    required this.overallLeaguePosition,
    required this.overallLeaguePlayed,
    required this.overallLeagueW,
    required this.overallLeagueD,
    required this.overallLeagueL,
    required this.overallLeagueGF,
    required this.overallLeagueGA,
    required this.overallLeaguePTS,
    required this.teamBadge,
    required this.stageName,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      countryName: json['country_name'],
      leagueId: json['league_id'],
      leagueName: json['league_name'],
      teamId: json['team_id'],
      teamName: json['team_name'],
      overallPromotion: json['overall_promotion'],
      overallLeaguePosition: json['overall_league_position'],
      overallLeaguePlayed: json['overall_league_payed'],
      overallLeagueW: json['overall_league_W'],
      overallLeagueD: json['overall_league_D'],
      overallLeagueL: json['overall_league_L'],
      overallLeagueGF: json['overall_league_GF'],
      overallLeagueGA: json['overall_league_GA'],
      overallLeaguePTS: json['overall_league_PTS'],
      teamBadge: json['team_badge'],
      stageName: json['stage_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country_name': countryName,
      'league_id': leagueId,
      'league_name': leagueName,
      'team_id': teamId,
      'team_name': teamName,
      'overall_promotion': overallPromotion,
      'overall_league_position': overallLeaguePosition,
      'overall_league_payed': overallLeaguePlayed,
      'overall_league_W': overallLeagueW,
      'overall_league_D': overallLeagueD,
      'overall_league_L': overallLeagueL,
      'overall_league_GF': overallLeagueGF,
      'overall_league_GA': overallLeagueGA,
      'overall_league_PTS': overallLeaguePTS,
      'team_badge': teamBadge,
      'stage_name': stageName,
    };
  }
}
