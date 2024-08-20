import 'package:football/models/team_model.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';

class TeamDetailPageController extends GetxController {
  List<Player> players = [];
  TeamModel team = TeamModel();

  bool isLoading = true;

  getTeam(teamId) async {
    isLoading = true;
    update();
    var response = await DioService.dio.get<String>("/api/v1/teams/$teamId");
    if (response.statusCode == 200) {
      var teamModel = teamModelFromJson(response.data!);
      team = teamModel;
      players = teamModel.players!;
      isLoading = false;
      update();
    }
  }
}
