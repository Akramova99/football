import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:football/presentation/home/controllers/base_page_controller.dart';
import 'package:football/presentation/home/pages/balance_page.dart';
import 'package:football/presentation/home/pages/home_page.dart';
import 'package:football/presentation/home/pages/settings_page.dart';
import 'package:football/presentation/home/pages/statistics/pages/statistics_page.dart';
import 'package:football/presentation/widgets/custom_bottom_navigation_item.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:get/get.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final controller = Get.find<BasePageController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BasePageController>(builder: (_) {
      return Scaffold(
        body: PageView(
          controller: controller.pageController,
          children: [
            HomePage(
              key: PageStorageKey("home"),
              pageController: controller.pageController,
            ),
            const StatisticsPage(
              key: PageStorageKey("statistics"),
            ),
            const BalancePage(
              key: PageStorageKey("balance"),
            ),

            const SettingsPage(
              key: PageStorageKey("setting"),
            )
          ],
          onPageChanged: (index) {
            controller.onPageChange(index);
          },
        ),
        // ImageFilter uchun import
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                  // Blur effektini qo'shish
                  child: Container(
                    width: 340,
                    decoration: BoxDecoration(
                      color: Colors.transparent,

                      // Faqat 20% opasity qo'lladik, shaffof bo'lishi uchun
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: BottomAppBar(
                      color:Colors.black87,

                      //  color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.onBottomNavItemClick(0);
                            },
                            child: CustomBottomNavigationItem(
                              data: bottomNavigation[0],
                              isSelected: controller.selectedItemIndex == 0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.onBottomNavItemClick(1);
                            },
                            child: CustomBottomNavigationItem(
                              data: bottomNavigation[1],
                              isSelected: controller.selectedItemIndex == 1,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.onBottomNavItemClick(2);
                            },
                            child: CustomBottomNavigationItem(
                              data: bottomNavigation[2],
                              isSelected: controller.selectedItemIndex == 2,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.onBottomNavItemClick(3);
                              print("hello");
                            },
                            child: CustomBottomNavigationItem(
                              data: bottomNavigation[3],
                              isSelected: controller.selectedItemIndex == 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
