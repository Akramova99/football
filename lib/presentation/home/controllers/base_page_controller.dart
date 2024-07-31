import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BasePageController extends GetxController {
  int selectedItemIndex = 0;
  PageController pageController = PageController();

  onBottomNavItemClick(int index) {
    selectedItemIndex = index;
    update();
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 10), curve: Curves.ease);
  }

  onPageChange(index) {
    selectedItemIndex = index;
    update();
  }
}
