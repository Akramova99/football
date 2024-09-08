import 'package:get/get.dart';

import '../../../../../models/team_reyting_model.dart';
import '../../../../../services/dio_service.dart';

class RatingPageController extends GetxController {
  List<TeamRatingModel> teams = [];

  getRating() async {
    var response = await DioService.GET(DioService.GET_RATING_TEAM_API, null);
    var _teams = teamRatingModelFromJson(response);
    teams = _teams;
    update();
  }
}
