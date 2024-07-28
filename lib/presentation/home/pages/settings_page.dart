
import 'package:flutter/material.dart';
import 'package:football/presentation/widgets/custom_home_menu_item.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:football/utils/constants/styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sozlamalar",
          style: CustomStyles.pageTitle,
        ),
        actions: [
          GestureDetector(
            child: SizedBox(
                height: 40,
                child: Image.asset("assets/images/settings/logout_img.png")),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            6,
            (index) => CustomHomeMenuItem(data: settingMenuItems[index]),
          ),
        ),
      ),

    );
  }
}
