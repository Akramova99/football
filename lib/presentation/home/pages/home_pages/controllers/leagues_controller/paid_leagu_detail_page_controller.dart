import 'package:football/models/league_detail_model.dart';
import 'package:get/get.dart';

import '../../../../../../services/db_service.dart';
import '../../../../../../services/dio_service.dart';
import '../../../../../widgets/toast.dart';

class PaidLeaguesDetailPageController extends GetxController {
  LeagueDetailModel league = LeagueDetailModel();

  getLeague(String id) async {
    try {
      var response =
      await DioService.dio.get<String>(DioService.LEAGUE_DETAIL_API + id);
      if (response.statusCode == 200) {
        var result = leagueDetailModelFromJson(response.data!);
        league = result;
        update();
      }
    } catch (e) {
      print("error hello $e");
    }
  }

  joinLeague(context) async {
    String? errorMessage = "";

    var userId = DbService.getUserId();
    try {
      var response = await DioService.dio
          .post(DioService.joinLeagueApi(league.id!, userId));

      if (response.statusCode == 200) {
        ToastService.showSuccess("Siz ligaga qo'shildingiz");
      } else {
        errorMessage = response.statusMessage;
      }
    } catch (e) {
      ToastService.showError(
          "$e" ?? "Siz ligaga qo'shilmadingiz, qayta urining");
    }
  }
}
