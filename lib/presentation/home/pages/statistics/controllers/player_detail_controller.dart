import 'package:football/models/player_detail_model.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

class PlayerDetailController extends GetxController {
  PlayerDetailModel? model;
  bool isLoading = false;

  getPlayerDetails(int playerId) async {
    isLoading = true;
    update();
    var response =
        await DioService.GET(DioService.getPlayerDetails(playerId), null);
    model = playerDetailModelFromJson(response);
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
