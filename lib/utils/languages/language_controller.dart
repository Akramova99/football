import 'dart:ui';

import 'package:get/get.dart';

class LanguageController extends GetxController {
  // Default language is English
  var locale = 'en'.obs;

  void changeLanguage(String langCode) {
    locale.value = langCode;
    Get.updateLocale(Locale(langCode));
  }
}
