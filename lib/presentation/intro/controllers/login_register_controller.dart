import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/pages/base_page.dart';

class LoginRegisterController extends GetxController {
  login(context) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext ctx) {
      return const BasePage();
    }), (route) => false);
  }

  register(BuildContext context){
    login(context);
  }
}
