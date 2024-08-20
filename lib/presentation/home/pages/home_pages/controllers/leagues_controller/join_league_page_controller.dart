import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

class JoinLeaguePageController extends GetxController {
  TextEditingController linkController = TextEditingController();

  joinLeagues(context) async {
    String? errorMessage = "";
    var leagueId = linkController.text;
    var userId = DbService.getUserId();

    try {
      var response =
          await DioService.dio.post(DioService.joinLeagueApi(leagueId, userId));

      if (response.statusCode == 200) {
        Navigator.of(context).popUntil(ModalRoute.withName('/a'));
      }
      if (response.statusCode == 410) {
        ToastService.showError("Siz bu ligada mavjudsiz");
      } else {
        ToastService.showError("Xatolik");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 410) {
        ToastService.showError("Xatolik");
      }
      if (e.response?.statusCode == 400) {
        ToastService.showError("Xatolik");
      }
    }
  }
}
