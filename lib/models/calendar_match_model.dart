



class CalendarMatch {
  String? homeTeam;
  String? awayTeam;
  String? homeLogo;
  String? awayLogo;
  int? homeTeamId;
  int? awayTeamId;
  String? homeFinalScore;
  String? awayFinalScore;
  String? matchStatus;
  String? matchDate;
  String? matchId;
  List<Statistics>? statistics;
  List<Goalscorers>? goalscorers;

  CalendarMatch(
      {this.homeTeam,
        this.awayTeam,
        this.homeLogo,
        this.awayLogo,
        this.homeTeamId,
        this.awayTeamId,
        this.homeFinalScore,
        this.awayFinalScore,
        this.matchStatus,
        this.matchDate,
        this.matchId,
        this.statistics,
        this.goalscorers});

  CalendarMatch.fromJson(Map<String, dynamic> json) {
    homeTeam = json['homeTeam'];
    awayTeam = json['awayTeam'];
    homeLogo = json['homeLogo'];
    awayLogo = json['awayLogo'];
    homeTeamId = json['homeTeamId'];
    awayTeamId = json['awayTeamId'];
    homeFinalScore = json['homeFinalScore'];
    awayFinalScore = json['awayFinalScore'];
    matchStatus = json['matchStatus'];
    matchDate = json['matchDate'];
    matchId = json['matchId'];
    if (json['statistics'] != null) {
      statistics = <Statistics>[];
      json['statistics'].forEach((v) {
        statistics!.add(Statistics.fromJson(v));
      });
    }
    if (json['goalscorers'] != null) {
      goalscorers = <Goalscorers>[];
      json['goalscorers'].forEach((v) {
        goalscorers!.add(Goalscorers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['homeTeam'] = homeTeam;
    data['awayTeam'] = awayTeam;
    data['homeLogo'] = homeLogo;
    data['awayLogo'] = awayLogo;
    data['homeTeamId'] = homeTeamId;
    data['awayTeamId'] = awayTeamId;
    data['homeFinalScore'] = homeFinalScore;
    data['awayFinalScore'] = awayFinalScore;
    data['matchStatus'] = matchStatus;
    data['matchDate'] = matchDate;
    data['matchId'] = matchId;
    if (statistics != null) {
      data['statistics'] = statistics!.map((v) => v.toJson()).toList();
    }
    if (goalscorers != null) {
      data['goalscorers'] = goalscorers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statistics {
  int? id;
  String? type;
  String? home;
  String? away;
  int? matchId;

  Statistics({this.id, this.type, this.home, this.away, this.matchId});

  Statistics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    home = json['home'];
    away = json['away'];
    matchId = json['matchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['home'] = home;
    data['away'] = away;
    data['matchId'] = matchId;
    return data;
  }
}

class Goalscorers {
  String? time;
  String? scorerType;
  String? name;
  int? scorerId;

  Goalscorers({this.time, this.scorerType, this.name, this.scorerId});

  Goalscorers.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    scorerType = json['scorerType'];
    name = json['name'];
    scorerId = json['scorerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['scorerType'] = scorerType;
    data['name'] = name;
    data['scorerId'] = scorerId;
    return data;
  }
}
