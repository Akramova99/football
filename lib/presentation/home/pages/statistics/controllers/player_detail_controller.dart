import 'dart:convert';

import 'package:football/models/player_detail_model.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

class PlayerDetailController extends GetxController {
  PlayerDetailModel? modelCurrent = PlayerDetailModel();
  Statistic current = Statistic();
  Statistic history = Statistic();
  bool isLoading = false;

  getPlayerDetails(int playerId) async {
    isLoading = true;
    update();
    var response =
        await DioService.GET(DioService.getPlayerDetails(playerId), null);
    modelCurrent = playerDetailModelFromJson(response);
    current = modelCurrent!.statistics!.isNotEmpty
        ? modelCurrent!.statistics![0]
        : Statistic();
    isLoading = false;
    update();
  }

  getPlayerHistoryDetails(int playerId) async {
    isLoading = true;
    update();
    var response = await DioService.GET(
        "/api/v1/players/$playerId/summary-statistics", null);
    var result = Statistic.fromJson(jsonDecode(response));
    history = result;
    isLoading = false;
    update();
  }

  int pageIndex = 0;

  onPageChange(int index) {
    print(index);
    pageIndex = index;
    update();
  }
}
