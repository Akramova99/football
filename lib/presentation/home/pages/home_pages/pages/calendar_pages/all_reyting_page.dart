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
      backgroundColor: Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        title: Text(
          "Umumiy reyting",
          style: CustomStyles.pageTitle,
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: SoccerRankingTable(
          teams: teams,
        ),
      ),
    );
  }
}
