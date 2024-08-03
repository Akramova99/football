import 'package:get/get.dart';

class BalancePageController extends GetxController {
  String? balance;

  getData(){
    balance = "100";
    update();
  }
}
