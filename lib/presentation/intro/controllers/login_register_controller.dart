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
      var response = await DioService.dio
          .post<String>(DioService.REGISTER_API, data: data);
      if (response.statusCode == 201) {
        ToastService.showSuccess("Ok");
        var userData = loginResponseModelFromJson(response.data!);
        userId = userData.userId.toString();

        var firebaseToken = DbService.getFirebaseToken();
        await DioService.dio.post(DioService.setFirebaseToken(userId),
            data: {"token": firebaseToken});

        DbService.saveUserid(userId.toString());
        DbService.setLoggedIn(true);
        DbService.saveUserEmail(email);
        setTeamIdToUserId();
        callBasePage(context);
      }
    } on Exception catch (e) {
      if (e.toString().contains("409")) {
        ToastService.showError("Bu telefon raqami ro'yhatdan o'tgan");
      }if (e.toString().contains("400")) {
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
      var response =
          await DioService.dio.post<String>(DioService.LOGIN_API, data: data);
      if (response.statusCode == 200) {
        ToastService.showSuccess("You are welcome");
        var userData = loginResponseModelFromJson(response.data!);
        userId = userData.userId.toString();

        DbService.saveUserid(userId.toString());

        var firebaseToken = DbService.getFirebaseToken();
        await DioService.dio.post(DioService.setFirebaseToken(userId),
            data: {"token": firebaseToken});

        DbService.setLoggedIn(true);
        DbService.saveUserEmail(email);
        callBasePage(context);
      }
      if (response.statusCode == 409) {
        ToastService.showError("${response.statusMessage}");
      } else {
        ToastService.showError("${response.statusMessage}");
        print("${response.statusMessage}");
      }
    } on Exception catch (e) {
      ToastService.showError("$e");
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
}
