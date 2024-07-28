import 'package:football/models/player_selection_model.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

class CreateTeamController extends GetxController {

  List<PlayerSelectionModel> players = [];


  getPlayer() async {
    var response = await DioService.GET(DioService.RANDOM_PLAYERS, null);
    players = playerModelFromJson(response);
    update();
  }
}
