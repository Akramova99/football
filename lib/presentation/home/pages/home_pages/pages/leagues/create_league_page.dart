import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/create_league_controller.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:get/get.dart';

class CreateLeaguePage extends StatefulWidget {
  const CreateLeaguePage({super.key});

  @override
  State<CreateLeaguePage> createState() => _CreateLeaguePageState();
}

class _CreateLeaguePageState extends State<CreateLeaguePage> {
  final controller = Get.find<CreateLeagueController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateLeagueController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Liga Yaratish'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Nomi',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: controller.description,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      key: const ValueKey("Start"),
                      value: controller.leagueStart,
                      decoration: InputDecoration(
                        labelText: 'Start Liga',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      items: List.generate(38, (index) => index + 1)
                          .map((value) => DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        controller.onWeekChange(true, newValue!);
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      key: const ValueKey("End"),
                      value: controller.leagueEnd,
                      decoration: InputDecoration(
                        labelText: 'End Liga',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      items: List.generate(38, (index) => index + 1)
                          .map((value) => DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        controller.onWeekChange(false, newValue!);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              CustomButton(
                text: "Liga Yaratish",
                onPress: () {
                  controller.createLeague(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
