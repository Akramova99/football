import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

class BalanceButton extends StatelessWidget {
  const BalanceButton({super.key, required this.title, required this.coins});
  final String title;
  final  int coins;
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
                buildOptionTile(400, 2.6, 'save 10%', false),
                const Divider(),
                buildOptionTile(400, 2.6, 'save 10%', false),
                const Divider(),
                buildOptionTile(400, 2.6, 'save 10%', true),
                const SizedBox(height: 10),
                CustomButton(text: "Checkout", onPress: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildOptionTile(
      int points, double price, String discount, bool isChecked) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent), // Remove borders
      ),
      child: Container(
        child: Row(
          children: [
            Checkbox(
              side: BorderSide(color: Colors.grey, width: 2),
              activeColor: Colors.green,
              value: isChecked,
              onChanged: (bool? value) {
              },
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
