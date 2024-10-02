import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/team_detail_page.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/styles.dart';

import '../../models/team_reyting_model.dart';
import '../../utils/constants/test.dart';

class SoccerRankingTable extends StatelessWidget {
  final List<TeamRatingModel> teams;

  const SoccerRankingTable({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: DataTable(
          headingRowColor:  WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
              // Set the color of the row to black
              return Colors.black;
            },
          ),
          columnSpacing: 10,
          border: TableBorder(
            bottom: BorderSide(color: Colors.grey.shade100, width: 0.5),
            horizontalInside: BorderSide(color: Colors.grey.shade100, width: 0.5),
          ),
          clipBehavior: Clip.hardEdge,
          dividerThickness: 1,
          columns:  [
            DataColumn(label: Text('#',style: CustomStyles.dataTitle,)),
            DataColumn(
              label: Text('Jamoalar',style: CustomStyles.dataTitle,),
            ),
            DataColumn(label: Text('M',style: CustomStyles.dataTitle,)),
            DataColumn(label: Text('PTS',style: CustomStyles.dataTitle,)),
          ],
          rows: List.generate(
            teams.length,
                (index) {
              final team = teams[index];
              return DataRow(
                onLongPress: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                    return TeamDetailPage(id: team.id ?? 0);
                  }));
                },
                color: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                    // Set the color of the row to black
                    return Colors.black;
                  },
                ),
                cells: [
                  DataCell(Text((index + 1).toString(), style: TextStyle(color: Colors.white))),
                  DataCell(Row(
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: team.logo != null
                            ? CachedNetworkImage(
                          imageUrl: team.logo!,
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) => Container(),
                        )
                            : Image.asset(teamLogos[Random().nextInt(teamLogos.length)]),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 120,
                        child: Text(
                          team.name!,
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  )),
                  DataCell(Text(team.currentScore!.toString(), style: TextStyle(color: Colors.white))),
                  DataCell(Text(team.totalScore!.toString(), style: TextStyle(color: Colors.white))),
                ],
              );
            },
          ),
        )
        ,
      ),
    );
  }
}
