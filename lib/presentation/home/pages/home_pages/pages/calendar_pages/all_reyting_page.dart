import 'package:flutter/material.dart';
import 'package:football/presentation/widgets/ranking_table_widget.dart';
import 'package:football/utils/constants/styles.dart';

import '../../../../../../models/team_reyting_model.dart';

class AllRatingPage extends StatelessWidget {
  final List<TeamRatingModel> teams;

  const AllRatingPage({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Umumiy reyting",
          style: CustomStyles.pageTitle,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SoccerRankingTable(
          teams: teams,
        ),
      ),
    );
  }
}
