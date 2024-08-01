import 'dart:math';

import '../../models/match_model.dart';

final teamNames = [
  'Man City',
  'Liverpool',
  'Chelsea',
  'Tottenham',
  'Arsenal',
  'Man Utd',
  'West Ham',
  'Leicester',
  'Brighton',
  'Newcastle Utd',
  'Aston Villa',
  'Wolves',
  'Crystal Palace',
  'Brentford',
  'Man City',
  'Liverpool',
  'Chelsea',
  'Tottenham',
  'Arsenal',
  'Man Utd',
  'West Ham',
  'Leicester',
  'Brighton',
  'Newcastle Utd',
  'Aston Villa',
  'Wolves',
  'Crystal Palace',
  'Brentford'
];

String getRandomTeamLogo() {
  final random = Random();
  return teamLogos[random.nextInt(teamLogos.length - 1)];
}

final teamLogos = [
  'assets/images/test/img_1.png',
  'assets/images/test/img_2.png',
  'assets/images/test/img_3.png',
  'assets/images/test/img_4.png',
  'assets/images/test/img_5.png',
  'assets/images/test/img_6.png',
  'assets/images/test/img_7.png',
  'assets/images/test/img_8.png',
  'assets/images/test/img_9.png',
  'assets/images/test/img_10.png',
  'assets/images/test/img_11.png',
  'assets/images/test/img_12.png',
  'assets/images/test/username_img.png',
  'assets/images/test/img_1.png',
  'assets/images/test/img_2.png',
  'assets/images/test/img_3.png',
  'assets/images/test/img_4.png',
  'assets/images/test/img_5.png',
  'assets/images/test/img_6.png',
  'assets/images/test/img_7.png',
  'assets/images/test/img_8.png',
  'assets/images/test/img_9.png',
  'assets/images/test/img_10.png',
  'assets/images/test/img_11.png',
  'assets/images/test/img_12.png',
  'assets/images/test/username_img.png',
];

List<MatchModel> generateRandomMatches() {
  final random1 = Random();
  final random2 = Random();

  List<MatchModel> matches = [];

  for (int i = 0; i < 10; i++) {
    final homeIndex = random1.nextInt(25);
    int awayIndex = random2.nextInt(23);
    if (awayIndex == homeIndex) {
      awayIndex += 2;
    }

    matches.add(MatchModel(
      id: i,
      home: Away(
        id: homeIndex,
        teamName: teamNames[homeIndex],
        logo: teamLogos[homeIndex],
        jersey: 'Home Jersey',
      ),
      away: Away(
        id: awayIndex,
        teamName: teamNames[awayIndex],
        logo: teamLogos[awayIndex],
        jersey: 'Away Jersey',
      ),
      matchWeek: MatchWeek(
        id: i,
        weekNumber: i + 1,
        startDate: DateTime.now().add(Duration(days: i * 7)),
        endDate: DateTime.now().add(Duration(days: i * 7 + 6)),
      ),
      startTime: DateTime.now().add(Duration(days: i)),
      matchDate: DateTime.now().add(Duration(days: i)),
    ));
  }

  return matches;
}
