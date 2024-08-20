import 'package:football/models/league_detail_model.dart';
import 'package:football/models/team_reyting_model.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

class LeagueDetailPageController extends GetxController {
  LeagueDetailModel? league;
  List<TeamRatingModel> team = [];

  getLeagueDetail(id) async {
    try {
      var response =
          await DioService.dio.get<String>(DioService.LEAGUE_DETAIL_API + id);
      if (response.statusCode == 200) {
        var result = leagueDetailModelFromJson(response.data!);
        league = result;
        print(league?.name);
        if (league != null) {
          team = league!.teams!;
        }
        update();
      }
    } catch (e) {
      print("error hello $e");
    }
  }


}
