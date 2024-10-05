import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../../../../models/match_model.dart';
import '../../../../../../services/db_service.dart';
import '../../../../../../services/dio_service.dart';
import '../../../../../widgets/toast.dart';
import '../../pages/leagues/leagues_page.dart';

class CreateLeagueController extends GetxController {
  int leagueStart = 1;
  int leagueEnd = 1;
  String img = '';
  File? imageFile;
  bool isUpload = false;
  bool isCreate = false;

  final ImagePicker picker = ImagePicker();

  TextEditingController nameController = TextEditingController();
  TextEditingController description = TextEditingController();

  List<MatchWeek> weeks = [];

  getWeeks() async {
    try {
      var response =
          await DioService.dio.get<String>(DioService.GET_MATCHES_API);
      if (response.statusCode == 200) {
        var list = matchWeekFromJson(response.data!);
        if (list.isNotEmpty) {
          weeks = list;
          update();
        }
      }
    } on DioException catch (e) {}
  }

  chooseImage() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50, // Compresses the image to 50% quality
    );

    if (image != null) {
      imageFile = File(image.path);
      isUpload = true;
      Logger().i("file");
    } // Store the image file

    // Assuming no other data is required, pass the image as a parameter
    var response = await DioService.POST2(DioService.UPLOAD_IMAGE, null, image);
    img = response;
    update();
    Logger().i(response);
  }

  createLeague(context) async {
    var userId = DbService.getUserId();
    Logger().i(userId);
    var data = {
      "name": nameController.text,
      "description": description.text,
      "startWeek": weeks[leagueStart].id,
      "endWeek": weeks[leagueEnd].id,
      "image": isUpload ? img : "string"
    };

    try {
      var response = await DioService.dio
          .post(DioService.LEAGUE_CREATE_API + userId, data: data);

      if (response.statusCode == 200) {
        ToastService.showSuccess("Liga yaratildi");
        isCreate = true;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LeaguesPage(),
        ));
      } else {
        ToastService.showError(response.statusMessage ?? "Liga yaratilmadi");
      }
    } catch (e) {
      ToastService.showError("Liga yaratilmadi");
    }
  }

  onWeekChange(bool isStart, int value) {
    if (isStart) {
      leagueStart = value;
    } else {
      leagueEnd = value;
    }
    update();
  }
}
