import 'package:dio/dio.dart';

class DioService {
  static const String SERVER = "http://64.227.145.145:8080";
  static Dio dio = Dio(BaseOptions(baseUrl: SERVER));

  static Future<String> POST(String api, Map? data) async {
    try {
      var response = await dio.post(api, data: data);
      if (response.statusCode == 200) {
        return response.data;
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

  static const RANDOM_PLAYERS = "/api/v1/players/random";
}
