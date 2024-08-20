import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:football/models/user_data_model.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:football/services/db_service.dart';
import 'package:football/services/dio_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mime/mime.dart';

class ProfilePageController extends GetxController {
  String? profileImage;
  String? name = "";
  late String userId;
  UserModel user = UserModel();

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
    print(userId);
    var response =
        await DioService.GET(DioService.USER_DATA_API + userId, null);
    user = userModelFromJson(response);
    name = user.username;
    profileImage = user.image;
    update();
  }

  chooseImage() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      imageFile = File(image.path);

      // Create a FormData object
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          imageFile!.path,
          filename: imageFile!.path.split('/').last,
          contentType: DioMediaType.parse(
              lookupMimeType(imageFile!.path)!), // Adjust contentType if needed
        ),
      });

      print('Form Data: ${formData.fields}');

      // Send the POST request using Dio
      try {
        var response = await Dio().post(
          'http://64.227.145.145:8080/api/v1/users/$userId/upload-image',
          data: formData,
          options: Options(
            headers: {
              'accept': '*/*',
              'Content-Type': 'multipart/form-data',
            },
          ),
        );

        // Handle the response
        if (response.statusCode == 200) {
          // Assuming getData is a function that fetches the latest data
          getData();
        } else {
          print('File upload failed with status: ${response.statusCode}');
          print('Response data: ${response.data}');
        }
      } on DioError catch (e) {
        print('DioError: ${e.message}');
        print('Response data: ${e.response?.data}');
      } catch (e) {
        print('Error uploading file: $e');
      }
    } else {
      // Handle the case when no image is selected
      print('No image selected.');
    }
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
