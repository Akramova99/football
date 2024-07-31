import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/team_reyting_model.dart';
import '../../utils/constants/test.dart';

class SoccerRankingTable extends StatelessWidget {
  final List<TeamRatingModel> teams;

  const SoccerRankingTable({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 10,
              blurRadius: 10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        padding: EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: DataTable(
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
                              ? Image.network(team.logo!)
                              : Image.asset(teamLogos[
                                  Random().nextInt(teamLogos.length)]),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 100,
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
      ),
    );
  }
}
