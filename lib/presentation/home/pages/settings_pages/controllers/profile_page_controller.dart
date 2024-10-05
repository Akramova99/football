import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:football/models/user_data_model.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

  class ProfilePageController extends GetxController {
  String? profileImage;
  String? name = "";
  String? img = "";
  late String userId;
  UserModel user = UserModel();
bool isUpload =false;
  TextEditingController nameCont = TextEditingController();
  TextEditingController phoneNumberCont = TextEditingController(text: "+998 ");
  TextEditingController passwordCont = TextEditingController();

  bool showPassword = false;

  hidePassword() {
    showPassword = !showPassword;
    update();
  }

  var phoneNumberMask = MaskTextInputFormatter(
    mask: '+998 ## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final ImagePicker picker = ImagePicker();
  File? imageFile;

  getData() async {
    userId = DbService.getUserId();
    Logger().i("Pfofile data: $userId");
    var response =
        await DioService.GET(DioService.USER_DATA_API + userId, null);
    user = userModelFromJson(response);
    name = user.username;
    profileImage = user.image;
    update();
  }

  chooseImage() async {
    userId = DbService.getUserId();
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
    var response = await DioService.POST2(DioService.chooseImg(userId), null, image);
    img = response;
    update();
    Logger().i(response);
  }


  updateUserData() async {
    var username = nameCont.text;
    var phoneNumber = phoneNumberCont.text;
    var password = passwordCont.text;
    var data = {
      "username": username,
      "email": phoneNumber,
      "password": password
    };

    if (username.isNotEmpty && password.isNotEmpty && phoneNumber.isNotEmpty) {
      var response = await DioService.dio
          .put(DioService.UPDATE_USERDATA_API + userId, data: data);
      if (response.statusCode == 200) {
        ToastService.showSuccess("Malumotlar o'zgartisrildi");
      }
      if (response.statusCode == 409) {
        ToastService.showError("Bu telefon raqami ro'yhatdan otgan");
      }
      if (response.statusCode == 400) {
        ToastService.showError("Bu ism ro'yhatdan otgan");
      }
    }
  }

}
