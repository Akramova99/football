import 'package:flutter/material.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../home/controllers/balance_page_controller.dart';

class BalanceButton extends StatelessWidget {
  const BalanceButton(
      {super.key,
      required this.title,
      required this.coins,
      required this.itemIndex,
      required this.chosenIndex,
      required this.onPress,
      required this.cost,
      required this.transferNumber});

  final int transferNumber;
  final int itemIndex;
  final int chosenIndex;
  final String title;
  final int coins;
  final Function onPress;
  final int cost;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 1),
            ), //BoxShadow
          ],
          borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        key: PageStorageKey<String>(title),
        shape: const Border(),
        leading: Image.asset("assets/images/balance/transfer_img.png"),
        title: Text(title.replaceAll("_", " ")),
        trailing: GestureDetector(
          onTap: () {
            Get.find<BalancePageController>().buyTransfer(title);
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(34, 245, 0, 1),
                borderRadius: BorderRadius.circular(7)),
            child: Text(
              '$coins coin',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                buildOptionTile(transferNumber, cost.toDouble()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOptionTile(int points, double price) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent), // Remove borders
      ),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                side: const BorderSide(color: Colors.grey, width: 2),
                activeColor: Colors.green,
                value: chosenIndex == itemIndex,
                onChanged: (bool? value) {
                  onPress(itemIndex, value ?? false);
                },
                shape: CircleBorder(),
              ),
              Text(
                "${points != -1 ? points : "Unlimited"}",
                style: const TextStyle(
                    fontSize: 20, color: Color.fromRGBO(233, 209, 0, 1)),
              ),
              const Spacer(),
              Column(
                children: [
                  Text(
                    "$price som",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              )
            ],
          ),
          if (itemIndex == chosenIndex)
            CustomButton(text: "Sotib olish", onPress: () {})
        ],
      ),
    );
  }
}
