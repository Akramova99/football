import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues/team_detail_page.dart';

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
          columnSpacing: 10,
          border: TableBorder(
            bottom: BorderSide(color: Colors.grey.shade100, width: 0.5),
            horizontalInside:
                BorderSide(color: Colors.grey.shade100, width: 0.5),
          ),
          clipBehavior: Clip.hardEdge,
          dividerThickness: 1,
          columns: const [
            DataColumn(label: Text('#')),
            DataColumn(
              label: Text('Jamoalar'),
            ),
            DataColumn(label: Text('M')),
            DataColumn(label: Text('PTS')),
          ],
          rows: List.generate(
            teams.length,
            (index) {
              final team = teams[index];
              return DataRow(
                onLongPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return TeamDetailPage(
                      id: team.id ?? 0,
                    );
                  }));
                },
                color: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (index == 1) return Colors.blue.withOpacity(0.1);
                    return null;
                  },
                ),
                cells: [
                  DataCell(Text((index + 1).toString())),
                  DataCell(Row(
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: team.logo != null
                            ? CachedNetworkImage(
                                imageUrl: team.logo!,
                                placeholder: (context, url) => Container(),
                                errorWidget: (context, url, error) =>
                                    Container(),
                              )
                            : Image.asset(
                                teamLogos[Random().nextInt(teamLogos.length)]),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: 120,
                        child: Text(
                          team.name!,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  )),
                  DataCell(Text(team.currentScore!.toString())),
                  DataCell(Text(team.totalScore!.toString())),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
