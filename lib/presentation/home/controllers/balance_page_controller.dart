import 'package:dio/dio.dart';
import 'package:football/models/transfer_maket_model.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:get/get.dart';

import '../../../models/user_data_model.dart';
import '../../../services/db_service.dart';
import '../../../services/dio_service.dart';

class BalancePageController extends GetxController {
  String userId = "";
  UserModel user = UserModel();

  ///api/v1/transfers/available-transfers-packs

  getUserData() async {
    userId = DbService.getUserId();
    var response =
        await DioService.GET(DioService.USER_DATA_API + userId, null);
    user = userModelFromJson(response);
    update();
  }

  List<TransferPacketModel> packets = [];
  int index = 0;

  getTransferPackets() async {
    try {
      var result = await DioService.dio
          .get<String>("/api/v1/transfers/available-transfers-packs");
      if (result.statusCode == 200) {
        packets = transferPacketModelFromJson(result.data!);
        update();
      }
    } on DioException catch (e) {
      //handle exception
    }
  }

  onPacketChosen(int packetIndex, bool isChosen) {
    if (isChosen) {
      index = packetIndex;
    } else {
      index = 0;
    }
    update();
  }

  buyTransfer(String transferName) async {
    print(
        "/api/v1/users/buy-transfer?userId=$userId&paidTransfer=$transferName");
    try {
      var result = await DioService.dio.post(
          "/api/v1/users/buy-transfer?userId=$userId&paidTransfer=$transferName");
      if (result.statusCode == 200) {
        ToastService.showSuccess("Transfer sotib olindi");
      }
    } on DioException catch (e) {
      print(e.response?.statusCode);
      if (e.response?.statusCode == 409) {
        ToastService.showError("Siz mablag' yetarli emas");
      } else {
        print(e);
      }
    }
  }
}
