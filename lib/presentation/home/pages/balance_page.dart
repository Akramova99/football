import 'package:flutter/material.dart';
import 'package:football/presentation/home/controllers/balance_page_controller.dart';
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
  Widget build(BuildContext context) {
    return GetBuilder<BalancePageController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Balans",
            style: CustomStyles.pageTitle,
          ),
        ),
      );
    });
  }
}
