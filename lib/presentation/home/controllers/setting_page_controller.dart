import 'package:flutter/material.dart';
import 'package:football/presentation/intro/pages/base_intro_page.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class SettingPageController extends GetxController {
  logOut(context) async {
    var email = DbService.getUserEmail();
    print(email);
    try {
      var response = await DioService.dio.post(
          DioService.LOG_OUT_API + DioService.logOuApi(email),
          data: null);
      print(response.statusMessage);
      if (response.statusCode == 204 || response.statusCode == 200) {
        DbService.setLoggedIn(false);
        DbService.clear();
        ToastService.showSuccess("Siz tizimdan chiqarib yuborildingiz");
        Get.deleteAll(force: true);
        callBaseIntroPage(context);
      } else {
        ToastService.showError("XAtolik yuz berdi");
      }
    } catch (e) {
      print("log out $e");
    }
  }

  callBaseIntroPage(context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return BaseIntroPage();
      }),
      (route) => false,
    );
  }

  changeLanguage() {}

  shareApp() async {
    await Share.share('check out my website https://example.com');
  }
}
