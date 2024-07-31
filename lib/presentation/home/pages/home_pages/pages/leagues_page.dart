import 'package:flutter/material.dart';
import 'package:football/utils/constants/styles.dart';

class LeaguesPage extends StatefulWidget {
  const LeaguesPage({super.key});

  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ligalar",
          style: CustomStyles.pageTitle,
        ),
      ),
    );
  }
}
