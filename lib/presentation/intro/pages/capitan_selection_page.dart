import 'package:flutter/material.dart';
import 'package:football/utils/constants/styles.dart';

import '../../widgets/football_field_widget.dart';

class CapitanSelectionPage extends StatefulWidget {
  const CapitanSelectionPage({super.key});

  @override
  State<CapitanSelectionPage> createState() => _CapitanSelectionPageState();
}

class _CapitanSelectionPageState extends State<CapitanSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Capitan tanlang",
          style: CustomStyles.pageTitle,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              FootballFieldWidget(),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
