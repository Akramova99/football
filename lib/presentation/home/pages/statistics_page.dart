import 'package:flutter/material.dart';

import '../../../utils/constants/styles.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text(
        "Statistika",
        style: CustomStyles.pageTitle,
      ),
    ),);
  }
}
