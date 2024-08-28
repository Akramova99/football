import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:football/models/match_model.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

class CreateLeagueController extends GetxController {
  int leagueStart = 1;
  int leagueEnd = 1;

  TextEditingController nameController = TextEditingController();
  TextEditingController description = TextEditingController();

  List<MatchWeek> weeks = [];

  getWeeks() async {
    try {
      var response =
          await DioService.dio.get<String>(DioService.GET_MATCHES_API);
      if (response.statusCode == 200) {
        var list = matchWeekFromJson(response.data!);
        if (list.isNotEmpty) {
          weeks = list;
          update();
        }
      }
    } on DioException catch (e) {}
  }

  createLeague(context) async {
    var userId = DbService.getUserId();
    var data = {
      "name": nameController.text,
      "description": description.text,
      "startWeek": weeks[leagueStart].id,
      "endWeek": weeks[leagueEnd].id,
      "image": "string"
    };

    try {
      var response = await DioService.dio
          .post(DioService.LEAGUE_CREATE_API + userId, data: data);

      if (response.statusCode == 200) {
        ToastService.showSuccess("Liga yaratildi");
        Navigator.of(context).popUntil(ModalRoute.withName('/a'));
      } else {
        ToastService.showError(response.statusMessage ?? "Liga yaratilmadi");
      }
    } catch (e) {
      ToastService.showError("Liga yaratilmadi");
    }
  }

  onWeekChange(bool isStart, int value) {
    if (isStart) {
      leagueStart = value;
    } else {
      leagueEnd = value;
    }
    update();
  }
}
