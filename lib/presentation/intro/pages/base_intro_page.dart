import 'package:flutter/material.dart';
import 'package:football/presentation/intro/pages/create_team_page.dart';
import 'package:football/presentation/intro/pages/intro_page.dart';
import 'package:football/presentation/intro/pages/select_team_name_page.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'capitan_selection_page.dart';

class BaseIntroPage extends StatefulWidget {
  const BaseIntroPage({super.key});

  @override
  State<BaseIntroPage> createState() => _BaseIntroPageState();
}

class _BaseIntroPageState extends State<BaseIntroPage> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                // IntroPag(
                //   key: PageStorageKey('IntroPage1'),
                //   introData: intro[0],
                // ),
                IntroPag(
                  key: PageStorageKey('IntroPage1'),
                  introData: intro[0],
                  isSkip: true,
                ),
                IntroPag(
                  key: PageStorageKey('IntroPage2'),
                  introData: intro[1],
                  isSkip: false,
                ),
                CreateTeamPage(
                  pageController: pageController,
                  key: PageStorageKey('IntroPage4'),
                ),
                CapitanSelectionPage(
                    pageController: pageController,
                    key: PageStorageKey('IntroPage5')),
                const SelectTeamNamePage(key: PageStorageKey('IntroPage6'))
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: 5,
            effect:  const ExpandingDotsEffect(
                radius: 10,
                dotHeight: 10,
                dotWidth: 10,
                spacing: 5,
                activeDotColor:AppColors.HRed,
                dotColor: AppColors.red),
          ),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
