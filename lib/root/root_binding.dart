import 'package:football/presentation/home/controllers/balance_page_controller.dart';
import 'package:football/presentation/home/controllers/base_page_controller.dart';
import 'package:football/presentation/home/controllers/home_page_controller.dart';
import 'package:football/presentation/home/controllers/setting_page_controller.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/calendar_page_controller.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/leagues_page_controller.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/my_team_controller.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/points_page_controller.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/transfer_page_controller.dart';
import 'package:football/presentation/home/pages/settings_pages/controllers/invite_friends_controller.dart';
import 'package:football/presentation/home/pages/settings_pages/controllers/notification_page_controller.dart';
import 'package:football/presentation/home/pages/statistics/controllers/statistics_page_controller.dart';
import 'package:football/presentation/intro/controllers/capitan_selection_controller.dart';
import 'package:football/presentation/intro/controllers/create_team_controller.dart';
import 'package:football/presentation/intro/controllers/login_register_controller.dart';
import 'package:football/presentation/intro/controllers/select_team_name_controller.dart';
import 'package:get/get.dart';

import '../presentation/home/pages/home_pages/controllers/leagues_controller/create_league_controller.dart';
import '../presentation/home/pages/home_pages/controllers/leagues_controller/extra_leagues_page_controller.dart';
import '../presentation/home/pages/home_pages/controllers/leagues_controller/join_league_page_controller.dart';
import '../presentation/home/pages/home_pages/controllers/leagues_controller/league_detail_page_controller.dart';
import '../presentation/home/pages/home_pages/controllers/leagues_controller/team_detail_page_controller.dart';
import '../presentation/home/pages/home_pages/controllers/rating_page_controller.dart';
import '../presentation/home/pages/settings_pages/controllers/profile_page_controller.dart';
import '../presentation/home/pages/statistics/controllers/player_detail_controller.dart';
import '../presentation/widgets/football_field_widget.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectTeamNameController(), fenix: true);
    Get.lazyPut(() => LoginRegisterController(), fenix: true);
    Get.lazyPut(() => BasePageController(), fenix: true);
    Get.lazyPut(() => HomePageController(), fenix: true);
    Get.lazyPut(() => PointsPageController(), fenix: true);
    Get.lazyPut(() => CreateTeamController(), fenix: true);
    //Get.lazyPut(() => FootballFieldController(), fenix: true);
    Get.lazyPut(() => CapitanSelectionController(), fenix: true);
    Get.lazyPut(() => MyTeamController(), fenix: true);
    Get.lazyPut(() => TransferPageController(), fenix: true);
    Get.lazyPut(() => LeaguesPageController(), fenix: true);
    Get.lazyPut(() => CalendarPageController(), fenix: true);
    Get.lazyPut(() => StatisticsPageController(), fenix: true);
    Get.lazyPut(() => SettingPageController(), fenix: true);
    Get.lazyPut(() => BalancePageController(), fenix: true);
    Get.lazyPut(() => ProfilePageController(), fenix: true);
    Get.lazyPut(() => NotificationPageController(), fenix: true);
    Get.lazyPut(() => InviteFriendsController(), fenix: true);
    Get.lazyPut(() => PlayerDetailController(), fenix: true);
    Get.lazyPut(() => LeagueDetailPageController(), fenix: true);
    Get.lazyPut(() => ExtraLeaguesPageController(), fenix: true);
    Get.lazyPut(() => JoinLeaguePageController(), fenix: true);
    Get.lazyPut(() => CreateLeagueController(), fenix: true);
    Get.lazyPut(() => TeamDetailPageController(), fenix: true);
    Get.lazyPut(() => RatingPageController(), fenix: true);
  }
}
