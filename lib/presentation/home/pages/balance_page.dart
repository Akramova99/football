import 'package:flutter/material.dart';
import 'package:football/models/transfer_maket_model.dart';
import 'package:football/presentation/home/controllers/balance_page_controller.dart';
import 'package:get/get.dart';

import '../../../utils/constants/styles.dart';
import '../../widgets/balance_button.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final controller = Get.find<BalancePageController>();

  @override
  void initState() {
    super.initState();
    controller.getUserData();
    controller.getTransferPackets();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BalancePageController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Balans",
            style: CustomStyles.pageTitle,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Hisobimda :",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "${controller.user.balance ?? ""}",
                    style: const TextStyle(
                        fontSize: 16, color: Color.fromRGBO(34, 245, 0, 1)),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  controller: ScrollController(),
                  children: List.generate(
                    controller.packets.length,
                    (index) {
                      TransferPacketModel packet = controller.packets[index];
                      return BalanceButton(
                        title: packet.name ?? "",
                        coins: packet.coinValue ?? 0,
                        itemIndex: index + 1,
                        chosenIndex: controller.index,
                        onPress: controller.onPacketChosen,
                        cost: packet.cost ?? 0,
                        transferNumber: packet.numberOfTransfers!,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
