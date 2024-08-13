import 'package:flutter/material.dart';
import 'package:football/models/team_name_model.dart';
import 'package:football/presentation/intro/pages/login_register_page.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

import '../../widgets/toast.dart';

class SelectTeamNameController extends GetxController {
  String? teamId;

  TextEditingController teamNameController = TextEditingController();
  List<TeamNamesModel> teams = [];
  int? teamIndex;

  getMyTeamId() {
    teamId = DbService.getTeamId();
  }

  getTeamIcons() async {
    var response = await DioService.GET(DioService.TEAM_NAMES_API, null);
    teams = teamNamesModelFromJson(response);
    update();
  }

  callRegisterPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext ctx) {
        return const LoginRegisterPage();
      }),
      (route) => true,
    );
  }

  selectTeam(int index) async {
    teamIndex = index;
    update();
  }

  save() async {
    var tactics = DbService.getTactics();
    getMyTeamId();
    if (teamId != null) {
      var teamName = teamNameController.text;
      var teamIcon = teams[teamIndex!].logo;
      var data = {"name": teamName, "tactic": tactics, "image": teamIcon};
      await DioService.PUT("${DioService.SELECT_NAME_API}$teamId", data);
    } else {
      ToastService.showError("Sizda jaoma mavjud emas, iltimos jamoni tanlang");
    }
  }
}
