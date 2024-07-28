import 'package:flutter/material.dart';
import 'package:football/presentation/intro/pages/create_team_page.dart';
import 'package:football/presentation/intro/pages/intro_page.dart';
import 'package:football/presentation/intro/pages/select_team_name_page.dart';
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

      body: Container(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  IntroPag(
                    introData: intro[0],
                  ),
                  IntroPag(
                    introData: intro[1],
                  ),
                  IntroPag(
                    introData: intro[2],
                  ),
                  const CreateTeamPage(),
                  const CapitanSelectionPage(),
                  const SelectTeamNamePage()
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: 6,
              effect: const JumpingDotEffect(
                  activeDotColor: Color(0xFF10A3A3),
                  dotColor: Color(0xFFB2EBF2)),
            ),
            const SizedBox(
              height: 60  ,
            )
          ],
        ),
      ),
    );
  }
}
