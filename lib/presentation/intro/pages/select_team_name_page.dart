import 'package:flutter/material.dart';
import 'package:football/presentation/intro/controllers/select_team_name_controller.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:football/presentation/widgets/team_logo_widget.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

class SelectTeamNamePage extends StatefulWidget {
  const SelectTeamNamePage({super.key});

  @override
  State<SelectTeamNamePage> createState() => _SelectTeamNamePageState();
}

class _SelectTeamNamePageState extends State<SelectTeamNamePage> {
  final _controller = Get.find<SelectTeamNameController>();

  @override
  void initState() {
    super.initState();
    _controller.getMyTeamId();
    _controller.getTeamIcons();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectTeamNameController>(builder: (_) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Jamoa tanlang",
            style: CustomStyles.pageTitle,
          ),
        ),
        body: _controller.teamId != null
            ? Padding(
                padding: EdgeInsets.all(30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: GridView.builder(
                          itemCount: _controller.teams.length,
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () {
                                _controller.selectTeam(index);
                              },
                              child: TeamLogoWidget(
                                team: _controller.teams[index],
                              ),
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(231, 231, 231, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: TextField(
                              controller: _controller.teamNameController,
                              decoration: const InputDecoration(
                                  hintText: "Jamoa nomi",
                                  border: InputBorder.none),
                            )),
                            _controller.teamIndex != null
                                ? TeamLogoWidget(
                                    team: _controller
                                        .teams[_controller.teamIndex!])
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: "Keyingi >",
                        onPress: () {
                          _controller.save(context);
                        },
                      )
                    ],
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.all(10),
                child: CustomButton(
                  text: "Davom etish",
                  onPress: () {
                    _controller.callRegisterPage(context);
                  },
                ),
              ),
      );
    });
  }
}
