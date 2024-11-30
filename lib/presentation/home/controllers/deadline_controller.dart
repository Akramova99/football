import 'dart:convert'; // JSON tahlil qilish uchun import

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../services/dio_service.dart';

class DeadlineController extends GetxController {
  String deadline = '';

  getDeadlineData() async {
    var response = await DioService.GET(DioService.DEADLINE, null);

    // Javobni tahlil qilish (agar JSON bo'lsa)
    if (response != null && response.isNotEmpty) {
      try {
        deadline =
            jsonDecode(response); // Agar API JSON ma'lumot yuborayotgan bo'lsa
      } catch (e) {
        Logger().e("JSON tahlil qilishda xato: $e");
        deadline =
            " "; // Agar JSON bo'lmasa, oddiy string sifatida olingan ma'lumotni oling
      }
    }

    Logger().i(deadline);
    update();
  }
}
