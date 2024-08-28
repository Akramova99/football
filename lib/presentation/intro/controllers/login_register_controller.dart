import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:football/models/log_reg_response_model.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../home/pages/base_page.dart';

class LoginRegisterController extends GetxController {
  TextEditingController userNameReg = TextEditingController();
  TextEditingController emailReg = TextEditingController(text: "+998 ");
  TextEditingController passwordReg = TextEditingController();

  TextEditingController emailLog = TextEditingController(text: "+998 ");
  TextEditingController passwordLog = TextEditingController();

  var phoneNumberMask = MaskTextInputFormatter(
    mask: '+998 ## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  bool showPassword = true;
  bool isUserDataSaved = false;
  String userId = "";

  String? teamId;

  hidePassword() {
    showPassword = !showPassword;
    update();
  }

  saveUserData() {
    isUserDataSaved = !isUserDataSaved;
    update();
  }

  getTeamId() {
    teamId = DbService.getTeamId();
  }

  bool isLoading = false;

  register(context) async {
    var username = userNameReg.text.trim();
    var email = emailReg.text.trim().removeAllWhitespace;
    print(email);
    var password = passwordReg.text.trim();
    var data = {
      "username": username,
      "email": email,
      "password": password,
      'User-Agent':
          'Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Mobile Safari/537.36',
    };

    try {
      isLoading = true;
      update();
      var response = await DioService.dio
          .post<String>(DioService.REGISTER_API, data: data);
      if (response.statusCode == 201) {
        ToastService.showSuccess("Ok");
        var userData = loginResponseModelFromJson(response.data!);
        userId = userData.userId.toString();

        var firebaseToken = DbService.getFirebaseToken();
        print(firebaseToken);
        var responseFirebase = await DioService.dio.post(
            DioService.setFirebaseToken(userId),
            data: {"token": firebaseToken});
        if (responseFirebase.statusCode == 200) {
          print(responseFirebase.statusCode);

          //sent notification
          sentNotification("/api/v1/notifications/welcome/", userId);
        } else {
          print(response.statusMessage);
        }
        var balance = DbService.getBalance();
        await DioService.dio.post("/api/v1/users/set-balance/$userId/$balance");
        DbService.saveUserid(userId.toString());

        DbService.setLoggedIn(true);
        DbService.saveUserEmail(email);
        setTeamIdToUserId();
        isLoading = false;
        update();
        callBasePage(context);
      }
    } on Exception catch (e) {
      if (e.toString().contains("409")) {
        ToastService.showError("Bu telefon raqami ro'yhatdan o'tgan");
      }
      if (e.toString().contains("400")) {
        ToastService.showError("Bu ism royhatdan otgan");
      }
    }
  }

  login(context) async {
    var email = emailLog.text.trim().removeAllWhitespace;
    print(email);
    var password = passwordLog.text.trim();
    var data = {
      "email": email,
      "password": password,
      'User-Agent':
          'Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Mobile Safari/537.36',
    };

    try {
      isLoading = true;
      update();
      var response =
          await DioService.dio.post<String>(DioService.LOGIN_API, data: data);
      if (response.statusCode == 200) {
        ToastService.showSuccess("You are welcome");
        var userData = loginResponseModelFromJson(response.data!);
        userId = userData.userId.toString();

        DbService.saveUserid(userId.toString());

        var firebaseToken = DbService.getFirebaseToken();
        print("token :$firebaseToken");
        var tokenResponse = await DioService.dio.post(
            DioService.setFirebaseToken(userId),
            data: {"token": firebaseToken});
        if (tokenResponse.statusCode == 200) {
          //send login notification
          sentNotification("/api/v1/notifications/login-alert/", userId);
        }
        isLoading = false;
        update();
        DbService.setLoggedIn(true);
        DbService.saveUserEmail(email);
        callBasePage(context);
      }
    } on Exception catch (e) {
      //ToastService.showError("$e");
      print("$e");
    }
  }

  setTeamIdToUserId() async {
    await DioService.POST("${DioService.ADD_TEAM_API}$userId/$teamId", null);
  }

  callBasePage(context) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext ctx) {
      return const BasePage();
    }), (route) => false);
  }

  sentNotification(String api, String id) async {
    try {
      var response = await DioService.dio.post(api + id);
      if (response.statusCode == 200) {
        print(response.data);
        print("sending notif to user success");
      }
    } on DioException catch (e) {
      print("sending notif to user$e");
    }
  }
}
