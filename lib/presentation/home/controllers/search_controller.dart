import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../models/team_model.dart';
import '../../../services/dio_service.dart';

class SearchMyController extends GetxController {
  Player myPlayer = Player();

  getPlayerData(String name) async {
    //Logger().i("Pfofile data: $userId");
    var response = await DioService.GET(DioService.SEARCH_Players + name, null);
    myPlayer = playerProfileFromJson(response).first;
    Logger().i(myPlayer.playerNumber);
    update();
  }
}
