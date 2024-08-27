import 'package:shared_preferences/shared_preferences.dart';

class DbService {
  static late SharedPreferences db;

  static init() async {
    db = await SharedPreferences.getInstance();
  }

  static saveTeamId(String teamId) {
    db.setString("team_id", teamId);
  }

  static getTeamId() {
    return db.getString("team_id");
  }

  static saveUserid(String userId) {
    db.setString("user_id", userId);
  }

  static saveBalance(double budget) {
    db.setDouble("budget", budget);
  }

  static getBalance() {
    return db.getDouble("budget");
  }

  static getUserId() {
    return db.getString("user_id");
  }

  static setLoggedIn(bool isLogged) {
    db.setBool("logged_in", isLogged);
  }

  static bool getLoggedIn() {
    return db.getBool("logged_in") ?? false;
  }

  static saveUserEmail(String email) {
    db.setString("user_email", email);
  }

  static String getUserEmail() {
    return db.getString("user_email") ?? "";
  }

  static clear() {
    db.clear();
  }

  static saveFirebaseToken(String token) {
    db.setString("firebase_token", token);
  }

  static String getFirebaseToken() {
    return db.getString("firebase_token") ?? "";
  }

  static saveTactics(String tactics) {
    db.setString("tactics", tactics);
  }

  static String getTactics() {
    return db.getString("tactics") ?? "";
  }
}
