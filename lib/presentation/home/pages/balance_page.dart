import 'package:flutter/material.dart';
import 'package:football/presentation/home/controllers/balance_page_controller.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../../utils/constants/styles.dart';

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
                  Text(
                    "Hisobimda :",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    controller.balance ?? "",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    buildTransferTile(context, '1 ta Transfer', 100),
                    buildTransferTile(context, '3 ta Transfer', 200),
                    buildTransferTile(context, '10 ta Transfer', 300),
                    buildTransferTile(context, 'Full Paket', 1000),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildTransferTile(BuildContext context, String title, int coins) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 1),
            ), //BoxShadow
          ],
          borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        shape: const Border(),
        leading: Image.asset("assets/images/balance/transfer_img.png"),
        title: Text(title),
        trailing: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(34, 245, 0, 1),
              borderRadius: BorderRadius.circular(7)),
          child: Text(
            '$coins coin',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                const Text('Lorem Ipsum is simply dummy.'),
                buildOptionTile(400, 2.6, 'save 10%'),
                const Divider(),
                buildOptionTile(400, 2.6, 'save 10%'),
                const Divider(),
                buildOptionTile(400, 2.6, 'save 10%'),
                const SizedBox(height: 10),
                CustomButton(text: "Checkout", onPress: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOptionTile(int points, double price, String discount) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent), // Remove borders
      ),
      child: Container(
        child: Row(
          children: [
            Checkbox(
              value: true,
              onChanged: (yes) {},
              shape: CircleBorder(),
            ),
            Text(
              "$points",
              style: const TextStyle(
                  fontSize: 20, color: Color.fromRGBO(233, 209, 0, 1)),
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  "\$$price",
                  style: const TextStyle(fontSize: 20),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    "$discount",
                    style: const TextStyle(fontSize: 5, color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
