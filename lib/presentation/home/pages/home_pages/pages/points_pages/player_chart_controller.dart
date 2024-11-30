import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../../../../../models/week_chart_model.dart';
import '../../../../../../services/dio_service.dart';

class PlayerChartController extends GetxController{
  List<MatchScore> matchScore=[];
  // getPlayerChartData(String playerId) async {
  //
  //   var response =
  //   await DioService.GET(DioService.getChartScore(playerId), null);
  //   matchScore = playerCharts2FromJson(response);
  //
  //   Logger().d(matchScore);
  //   Logger().d(playerId);
  //   Logger().d(matchScore.first.totalScore);
  //   update();
  // }
  getPlayerByTypeChartData(String playerId,startWeek,endWeek) async {

    var response =
    await DioService.GET("/api/v1/players/$playerId/scores?startWeek=$startWeek&endWeek=$endWeek", null);
    matchScore = playerCharts2FromJson(response);

    Logger().d(matchScore);
    Logger().d(playerId);
    Logger().d(matchScore.first.totalScore);
    update();
  }

}