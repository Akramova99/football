import 'dart:math';

import '../../models/league_detail_model.dart';
import '../../models/league_model.dart';
import '../../models/matchweek_model.dart';
import '../../models/team_reyting_model.dart';

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
//  'assets/images/test/username_img.png',
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
  //'assets/images/test/username_img.png',
];

List<LeagueModel> generateRandomLeagues(int count) {
  Random random = Random();

  List<LeagueModel> leagues = [];

  for (int i = 0; i < count; i++) {
    leagues.add(
      LeagueModel(
        id: i.toString(),
        name: 'League ${i + 1}',
        description: 'Description of League ${i + 1}',
        expired: random.nextBool(),
        createdAt: DateTime.now().subtract(Duration(days: random.nextInt(100))),
        image: 'https://example.com/league${i + 1}.png',
        startWeek: generateRandomMatchweek(),
        endWeek: generateRandomMatchweek(),
        createdBy: 'User${random.nextInt(1000)}',
      ),
    );
  }

  return leagues;
}

MatchweekModel generateRandomMatchweek() {
  Random random = Random();
  int startDay = random.nextInt(365);
  return MatchweekModel(
    id: random.nextInt(100),
    weekNumber: random.nextInt(52) + 1,
    startDate: DateTime.now().subtract(Duration(days: startDay)),
    endDate: DateTime.now().subtract(Duration(days: startDay - 7)),
  );
}

LeagueDetailModel createLeagueDetail() {
  return LeagueDetailModel(
    id: "1",
    name: "Premier League",
    teams: [
      TeamRatingModel(
        id: 1,
        name: "Team A",
        totalScore: 95,
        currentScore: 3,
        logo: "https://example.com/team_a_logo.png",
      ),
      TeamRatingModel(
        id: 2,
        name: "Team B",
        totalScore: 89,
        currentScore: 2,
        logo: "https://example.com/team_b_logo.png",
      ),
      // Add more teams as needed
    ],
    description: "Top tier football league",
    expired: false,
    createdAt: DateTime.now(),
    image: "https://example.com/league_image.png",
    startWeek: MatchweekModel(
      id: 1,
      weekNumber: 1,
      startDate: DateTime(2024, 8, 1),
      endDate: DateTime(2024, 8, 7),
    ),
    endWeek: MatchweekModel(
      id: 38,
      weekNumber: 38,
      startDate: DateTime(2025, 5, 15),
      endDate: DateTime(2025, 5, 21),
    ),
    createdBy: "Admin",
  );
}
