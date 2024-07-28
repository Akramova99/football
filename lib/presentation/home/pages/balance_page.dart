import 'package:flutter/material.dart';

import '../../../utils/constants/styles.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Balans",
          style: CustomStyles.pageTitle,
        ),
      ),
    );
  }
}
