import 'package:flutter/material.dart';
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
    // TODO: implement initState
    super.initState();
    controller.getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<BalancePageController>();
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
                    controller.balance ?? "",
                    style: const TextStyle(
                        fontSize: 16, color: Color.fromRGBO(34, 245, 0, 1)),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  controller: ScrollController(),
                  children: [
                    BalanceButton(title: '1 ta Transfer', coins: 100),
                    BalanceButton(title: '3 ta Transfer', coins: 200),
                    BalanceButton(title: '4ta Transfer', coins: 300),
                    BalanceButton(title: 'Full packet', coins: 1000),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
