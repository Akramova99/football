import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';

class DioService {
  static const String SERVER = "http://46.101.131.127:8080";
  static Dio dio = Dio(BaseOptions(baseUrl: SERVER));

  static Future<String> POST(String api, Map? data) async {
    try {
      var response = await dio.post<String>(api, data: data);
      Logger().d("status code ${response.statusCode}api$api");
      if (response.statusCode == 200) {

        return "${response.data}";
      } else {
        print(response.statusMessage);
        return "${response.statusMessage}";
      }
    } on Exception catch (e) {
      return "$e";
    }
  }
  static Future<String> POST2(String api, Map<String, dynamic>? data, XFile? image) async {
    try {
      FormData formData = FormData();

      if (data != null) {
        data.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      if (image != null) {
        formData.files.add(MapEntry(
          'file', // Ensure this key matches your backend's expected parameter
          await MultipartFile.fromFile(image.path, filename: image.name),
        ));
      }

      // Log formData to see what's being sent
      Logger().i(formData.fields);
      Logger().i(formData.files);

      var response = await dio.post<String>(api, data: formData);

      if (response.statusCode == 200) {
        Logger().i(response.statusCode);
        Logger().i(response);
        return "${response.data}";
      } else {
        Logger().e("Status code: ${response.statusCode}, Message: ${response.statusMessage}");
        return "${response.statusMessage}";
      }
    } on DioException catch (e) {
      Logger().e("DioError: $e");
      return "$e";
    } catch (e) {
      Logger().e("Exception: $e");
      return "$e";
    }
  }



  static Future<String> GET(String api, Map? data) async {
    try {
      var response = await dio.get<String>(api, data: data);
      if (response.statusCode == 200) {
        return response.data ?? "";
      } else {
        return "${response.statusMessage}";
      }
    } on Exception catch (e) {
      return "$e";
    }
  }

  static Future<String> PUT(String api, Map? data) async {
    try {
      var response = await dio.put<String>(api, data: data);
      if (response.statusCode == 200) {
        return response.data ?? "";
      } else {
        return "${response.statusMessage}";
      }
    } on Exception catch (e) {
      return "$e";
    }
  }

  static String addPlayerAPI(String teamId, String playerId, bool isPrimary) {
    return "/api/v1/teams/$teamId/players/$playerId/$isPrimary";
  }

  static String logOuApi(String email) {
    var newEmail = email.replaceFirst("+", "%2B");
    print("new email " + newEmail);
    return newEmail;
  }

  static changePlayer(String teamId, playerId, bool isPrimary) {
    return "/api/v1/teams/$teamId/change-primary/players/$playerId/$isPrimary";
  }

  static postImage(String userId) {
    return "/api/v1/users/$userId/upload-image";
  }
  static getMatch(int matchId) {
    return "/api/v1/event-statistics/$matchId/game-statistics";
  }

  static sellPLayer(userid, teamid, playerid) {
    return "/api/v1/transfers/$userid/sell/$playerid/$teamid";
  }

  static buyPLayer(userid, teamid, playerid, isPrimary) {
    return "/api/v1/transfers/$userid/buy/$playerid/$teamid/$isPrimary";
  }

  static setFirebaseToken(String userId) {
    return "/api/v1/users/$userId/save-token";
  }
  static chooseImg(String userId) {
    return "/api/v1/users/$userId/upload-image";
  }

  static getPlayerDetails(int playerId) {
    return "/api/v1/players/$playerId/statistics";
  }

  static getPlayerHistory(int playerId) {
    return "/api/v1/players/$playerId/current-matchweek-statistics";
  }

  static joinLeagueApi(String leagueId, String userId) {
    return "/api/v1/users/$leagueId/join?userId=$userId";
  }

  static const GET_NOTIFICATION = "/api/v1/users/1/notifications";
  static const GET_TEAM_API = "/api/v1/teams/";
  static const RANDOM_PLAYERS_API = "/api/v1/players";
  static const CREATE_TEAM_API = "/api/v1/teams/create";
  static const UPLOAD_IMAGE = "/api/v1/leagues/upload-image/league";
  static const SELECT_CAPTAIN_API = "/api/v1/teams/assign-capitan";
  static const TEAM_NAMES_API = "/api/v1/favourite/teams";
  static const SELECT_NAME_API = "/api/v1/teams/update/";
  static const REGISTER_API = "/auth/register/user";
  static const LOGIN_API = "/auth/login";
  static const ADD_TEAM_API = "/api/v1/users/add/team/";
  static const USER_DATA_API = "/api/v1/users/";
  static const GET_MYTEAM_API = "/api/v1/users/my-team/";
  static const GET_RATING_TEAM_API = "/api/v1/teams/desc";
  static const GET_MATCHES_API = "/api/matchweeks";
  static const GET_MATCH_TEAMS_API = "/api/calendars/matchWeek/";
  static const LOG_OUT_API = "/auth/logout?email=";
  static const POINT_STATISTICS_API = "/api/v1/teams/stats";
  static const UPDATE_USERDATA_API = "/api/v1/users/update/";
  static const PLAYER_FILTER = "/api/v1/players/filter";
  static const TRANSFER_SUMMARY = "/api/v1/users/tranfer-summary/";
  static const ALL_ClUBS = "/api/football-teams/all";
  static const CURRENT_MATCHWEEK = "/api/matchweeks/current";
  static const PLAYER_STATISTIC = "/api/v1/players/api/players/statistics?position=";
  static const BALANCE_API = "/api/v1/transfers/available-transfers-packs";
  static const SEARCH_Players = "/api/v1/players/search/";

  static const LEAGUE_EXTRA_API = "/api/v1/leagues";
  static const LEAGUE_DETAIL_API = "/api/v1/leagues/";
  static const LEAGUE_PAID_API = "/api/v1/leagues/available";
  static const LEAGUES_API = "/api/v1/users/joinedLeagues?userId=";
  static const LEAGUE_CREATE_API = "/api/v1/leagues/create/";


  //transfer buy

}
