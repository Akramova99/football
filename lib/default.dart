import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/leagues_controller/create_league_controller.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/widgets/create_button.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/styles.dart';

class CreateLeaguePage extends StatefulWidget {
  const CreateLeaguePage({super.key});

  @override
  State<CreateLeaguePage> createState() => _CreateLeaguePageState();
}


class _CreateLeaguePageState extends State<CreateLeaguePage> {
  final controller = Get.find<CreateLeagueController>();
  bool isChooseImg = false;
  final FocusNode _focusNode = FocusNode();
  double boxWidth = 516; // Initial width

  @override
  void initState() {
    super.initState();
    controller.getWeeks();

    // Add a listener to the TextField focus node
    _focusNode.addListener(() {
      setState(() {
        boxWidth = _focusNode.hasFocus ? 600 : 516;
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
    return GetBuilder<CreateLeagueController>(builder: (_) {
      return SizedBox(
        height: boxWidth, // Use the dynamic width here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Liga Yaratish',
                    style: CustomStyles.appBarStyle.copyWith(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              !isChooseImg
                  ? InkWell(
                onTap: () async {
                  await controller.chooseImage();
                  setState(() {
                    isChooseImg = true;
                  });
                },
                child: _buildImagePicker(),
              )
                  : _buildSelectedImage(),
              const SizedBox(height: 16.0),
              _buildNameField(),
              const SizedBox(height: 16.0),
              _buildDropdowns(),
              const SizedBox(height: 24.0),
              CreateButton(
                text: "Liga yaratish",
                onPress: () {
                  controller.createLeague(context);
                },
                color: AppColors.cyan,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nomi',
          style: CustomStyles.appBarStyle.copyWith(fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 6.0),
        TextField(
          controller: controller.nameController,
          focusNode: _focusNode, // Assign the focus node
          decoration: InputDecoration(
            label: Row(
              children: [
                const Icon(
                  Icons.person_add_alt,
                  size: 18,
                  color: AppColors.purple,
                ),
                const SizedBox(width: 5),
                Text(
                  'Uzb cup',
                  style: CustomStyles.appBarStyle.copyWith(
                      fontWeight: FontWeight.w400, color: AppColors.purple),
                ),
              ],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildImagePicker() {
    return Container(
      height: 65,
      width: 323,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        margin: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image_outlined,
              color: AppColors.purple,
            ),
            Text(
              'Take Gallery (JPG,PNG)',
              style: CustomStyles.appBarStyle.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedImage() {
    return Center(
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: ClipOval(
                    child: controller.isUpload
                        ? Image.file(
                      controller.imageFile!,
                      width: 90,
                      height: 87,
                      fit: BoxFit.cover,
                    )
                        : SizedBox()
                  // CachedNetworkImage(
                  //   imageUrl:
                  //       "http://46.101.131.127:8080/api/v1/files/${controller.img}",
                  //   width: 90,
                  //   height: 87,
                  //   fit: BoxFit.cover,
                  //   placeholder: (context, url) => Image.asset(
                  //     "assets/images/home/player_img.png",
                  //   ),
                  //   errorWidget: (context, url, error) => Image.asset(
                  //     "assets/images/home/player_img.png",
                  //     width: 54,
                  //   ),
                  // ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned(
                top: 0,
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isChooseImg = false;
                        });
                      },
                      icon: const Icon(
                        Icons.close_outlined,
                        color: AppColors.redy,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildDropdowns() {
    return GetBuilder<CreateLeagueController>(
        builder: (_) => Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                key: const ValueKey("Start"),
                value: controller.leagueStart,
                decoration: InputDecoration(
                  labelText: 'Start Liga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: _buildDropdownItems(),
                onChanged: (newValue) {
                  //  controller.onWeekChange(true, newValue!);
                  controller.onWeekChange(true, 1);
                  Logger().w("Bosildi");
                  setState(() {});
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: _buildDropdownItems(),
                onChanged: (newValue) {
                  //  controller.onWeekChange(false, newValue!);
                  controller.onWeekChange(false, newValue!);
                  Logger().w("Bosildi2");
                  setState(() {});
                },
              ),
            ),
          ],
        ));
  }
  List<DropdownMenuItem<int>> _buildDropdownItems() {
    return List.generate(controller.weeks.length, (index) => index + 1)
        .map((value) => DropdownMenuItem<int>(
      value: value,
      child: Text("${controller.weeks[value - 1].weekNumber ?? ""}"),
    ))
        .toList();
  }
// Rest of your widget methods (_buildImagePicker, _buildSelectedImage, _buildDropdowns)...
}
