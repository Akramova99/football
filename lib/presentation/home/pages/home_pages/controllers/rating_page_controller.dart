import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../models/league_model.dart';
import '../../../../../models/team_reyting_model.dart';
import '../../../../../services/db_service.dart';
import '../../../../../services/dio_service.dart';

class RatingPageController extends GetxController {
  List<TeamRatingModel> teams = [];
  List<LeagueModel> myJoinedLeagues = [];

  getRating() async {
    var response = await DioService.GET(DioService.GET_RATING_TEAM_API, null);
    teams = teamRatingModelFromJson(response);

    update();
  }

  getJoinedLeagues() async {
    String userId = DbService.getUserId();
    var response =
        await DioService.dio.get<String>(DioService.LEAGUES_API + userId);
    var response2 = await DioService.dio
        .get<String>("${DioService.MY_LEAUGE}?userId=$userId");
    if (response.statusCode == 200 && response2.statusCode == 200) {
      var result = leagueModelFromJson(response.data!);
      var result2 = leagueModelFromJson(response2.data!);



      myJoinedLeagues.addAll(result);
      myJoinedLeagues.addAll(result2);
      Logger().d(myJoinedLeagues.length);
      Logger().d(response2);
      Logger().d(response);

      update();
    }
  }
}
