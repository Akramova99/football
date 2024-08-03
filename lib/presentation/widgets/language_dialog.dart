import 'package:flutter/material.dart';

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
              SizedBox(height: 10),
              buildLanguageOption(
                  context, 'Uzb', 'assets/images/settings/uzb_l.png'),
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
      Navigator.of(context).pop(); // Close the dialog
      print(language);
    },
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
