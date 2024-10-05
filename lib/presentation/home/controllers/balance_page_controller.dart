import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:football/models/transfer_maket_model.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../models/chart_model.dart';
import '../../../models/payment_history_model.dart';
import '../../../models/user_data_model.dart';
import '../../../services/db_service.dart';
import '../../../services/dio_service.dart';

class BalancePageController extends GetxController {
  String userId = "";
  UserModel user = UserModel();
  List<PaymentHistory> payment = [];
  List<YearlyPayment> chart = [];
  String paymentUrl = '';
  ///api/v1/transfers/available-transfers-packs

  getUserData() async {
    userId = DbService.getUserId();
    var response =
        await DioService.GET(DioService.USER_DATA_API + userId, null);
    user = userModelFromJson(response);
    update();
  }

  getChartData() async {
    userId = DbService.getUserId();
    DateTime year = DateTime.now();

    int currentYear =year.year;
    var response =
        await DioService.GET(DioService.chartApi(userId, currentYear), null);
    chart = yearlyPaymentsFromJson(response);
    Logger().i(response);
    // Logger().i(chart[0].monthlyPayments[0].month);
    update();
  }

  postPayment(String packetName)async{
    userId = DbService.getUserId();
    paymentUrl = await DioService.POST(DioService.balanceForTransfer(userId, packetName), null);
   // var response = await DioService.POST(DioService.balanceForTransfer(userId, packetName), null);
   //  paymentUrl = jsonDecode(response);
    Logger().i(paymentUrl);
  }

  List<TransferPacketModel> packets = [];
  int index = 0;

  getTransferPackets() async {
    try {
      var result = await DioService.dio.get<String>(DioService.BALANCE_API);
      if (result.statusCode == 200) {
        packets = transferPacketModelFromJson(result.data!);
        Logger().e(packets[0].name);
        update();
      }
    } on DioException catch (e) {
      Logger().e(e);
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

  getPaymentHistory() async {
    String userId = DbService.getUserId();
    var response = await DioService.GET(DioService.getPayment(userId), null);
    Logger().i(response);
    payment = paymentHistoryModelFromJson(response);
    Logger().i(payment[0]);

    update();
  }
}
