import 'package:flutter/material.dart';
import 'package:football/presentation/intro/controllers/select_team_name_controller.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SelectTeamNamePage extends StatefulWidget {
  const SelectTeamNamePage({super.key});

  @override
  State<SelectTeamNamePage> createState() => _SelectTeamNamePageState();
}

class _SelectTeamNamePageState extends State<SelectTeamNamePage> {
  final _controller = Get.find<SelectTeamNameController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Jamoa tanlang",
          style: CustomStyles.pageTitle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                color: Colors.blueGrey,
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey),
                child: TextField(
                  onSubmitted: (text) {},
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: "Keyingi >",
                onPress:(){
                  _controller.callRegisterPage(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
