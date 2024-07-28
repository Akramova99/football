import 'package:flutter/material.dart';
import 'package:football/presentation/intro/pages/login_register_page.dart';
import 'package:get/get.dart';

class SelectTeamNameController extends GetxController {
  callRegisterPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext ctx) {
        return const LoginRegisterPage();
      }),
      (route) => true,
    );
  }
}
