import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/join_league_page_controller.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/widgets/create_button.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/styles.dart';
import '../../controllers/leagues_controller/extra_leagues_page_controller.dart';

class JoinLeaguePage extends StatefulWidget {
  const JoinLeaguePage({super.key});

  @override
  State<JoinLeaguePage> createState() => _JoinLeaguePageState();
}

class _JoinLeaguePageState extends State<JoinLeaguePage> {
  final controller = Get.find<JoinLeaguePageController>();
  final controllerJoin = Get.find<ExtraLeaguesPageController>();
  final FocusNode _focusNode = FocusNode();
  double boxWidth = 406; // Initial width
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        boxWidth = _focusNode.hasFocus ? 600 : 406;
      });
    });
  }
  @override
  void dispose() {
    _focusNode.dispose(); // Dispose the focus node when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JoinLeaguePageController>(builder: (_) {
      return SizedBox(
        height: boxWidth,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ligalarga Qo'shilish",
                    style: CustomStyles.appBarStyle.copyWith(fontSize: 24),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text(
                'Kodni kiriting',
                style: CustomStyles.appBarStyle
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10,),
              TextField(
                focusNode: _focusNode,
                controller: controller.linkController,
                decoration: InputDecoration(
                  hintText: 'Kodni kiriting',
                  hintStyle: CustomStyles.dataTitle!.copyWith(color: AppColors.purple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CreateButton(
                  text: "Liga yaratish",
                  onPress: () {

                    controllerJoin.joinLeague(context);
                  },
                  color: AppColors.cyan),
            ],
          ),
        ),
      );
    });
  }
}
