import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/join_league_page_controller.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:get/get.dart';

class JoinLeaguePage extends StatefulWidget {
  const JoinLeaguePage({super.key});

  @override
  State<JoinLeaguePage> createState() => _JoinLeaguePageState();
}

class _JoinLeaguePageState extends State<JoinLeaguePage> {
  final controller = Get.find<JoinLeaguePageController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JoinLeaguePageController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Ligalarga Qo\'shilish'),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: controller.linkController,
                decoration: InputDecoration(
                  hintText: 'Silka kiriting',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                  text: 'Ligaga Qo\'shilish', onPress:(){
                controller.joinLeagues(context);
              }),
            ],
          ),
        ),
      );
    });
  }
}
