import 'package:dio/dio.dart';

class DioService {
  static const String SERVER = "http://64.227.145.145:8080";
  static Dio dio = Dio(BaseOptions(baseUrl: SERVER));

  static Future<String> POST(String api, Map? data) async {
    try {
      var response = await dio.post<String>(api, data: data);
      if (response.statusCode == 200) {
        return "${response.data}";
      } else {
        return "${response.statusMessage}";
      }
    } on Exception catch (e) {
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
    var newEmail = email.replaceFirst("@", "%40");
    print(newEmail);
    return newEmail;
  }

  static const GET_TEAM_API = "/api/v1/teams/";
  static const RANDOM_PLAYERS_API = "/api/v1/players";
  static const CREATE_TEAM_API = "/api/v1/teams/create";
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
}
