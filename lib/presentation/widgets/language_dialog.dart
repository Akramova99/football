import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

void showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildLanguageOption(
                  context, 'Ru', 'assets/images/settings/rus_l.png'),
              const SizedBox(height: 10),
              buildLanguageOption(
                  context, 'Uzb', 'assets/images/settings/uzb_l.png'),
              const SizedBox(height: 10),
              buildLanguageOption(
                  context, 'En', 'assets/images/settings/usa_flag.png'),
            ],
          ),
        ),
      );
    },
  );
}

Widget buildLanguageOption(
    BuildContext context, String language, String asset) {
  return GestureDetector(
      onTap: () {
        // Perform language switch based on the selected language
        if (language == "Ru") {
          // Set to Russian
          Get.updateLocale(Locale('ru', 'RU'));
          Logger().e("Ru nkdsj");
        } else if (language == "Uzb") {
          // Set to Uzbek
          Get.updateLocale(Locale('uz', 'UZ'));
        } else if (language == "En") {
          // Set to English
          Get.updateLocale(Locale('en', 'US'));
        }

        // Close the dialog after selecting the language
        Navigator.of(context).pop();

        // Print the selected language for debugging purposes
        print(language);
      }
,
      child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(asset, width: 24, height: 24),
          SizedBox(width: 10),
          Text(
            language,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
  );
}
