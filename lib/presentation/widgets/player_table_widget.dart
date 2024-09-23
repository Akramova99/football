import 'package:flutter/material.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/styles.dart';

import '../../models/player_detail_model.dart';

class PlayerDataTable extends StatelessWidget {
  final Statistic model;

  const PlayerDataTable({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(4),
            1: FlexColumnWidth(1),
          },
          children:  const [
            TableRow(
              decoration:
                  BoxDecoration(color: AppColors.chartC),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Match week',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(),
              ],
            ),
            TableRow(
              decoration:
                  BoxDecoration(color: AppColors.chartC),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Statistics',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Points',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
        Table(
          border: TableBorder.all(color: Colors.grey),
          columnWidths: const {
            0: FlexColumnWidth(4),
            1: FlexColumnWidth(1),
          },
          children: [
            TableRow(
                decoration: BoxDecoration(color: AppColors.chartC),
                children: [
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Assist',style: CustomStyles.dataTitle,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${model.scoreDetails?.assist ?? "-"}",
                  style: CustomStyles.dataTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            TableRow(
                decoration: BoxDecoration(color: AppColors.chartC),
                children: [
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Halff time',style: CustomStyles.dataTitle),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "${model.scoreDetails?.halfTime ?? "-"}",
                  style: CustomStyles.dataTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            TableRow(
                decoration: BoxDecoration(color: AppColors.chartC),
                children: [
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Red',style: CustomStyles.dataTitle),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${model.scoreDetails?.red ?? "-"}',
                  style: CustomStyles.dataTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            TableRow(
                decoration: BoxDecoration(color: AppColors.chartC),
                children: [
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Yellow',style: CustomStyles.dataTitle
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '${model.scoreDetails?.yellow ?? "-"}',
                  style: CustomStyles.dataTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
            TableRow(
                decoration: BoxDecoration(color: AppColors.chartC),
                children: [
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Total',
                    style: CustomStyles.dataTitle),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${model.totalScore ?? "-"}',
                  style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
          ],
        ),
      ],
    );
  }
}

class PlayerStats extends StatelessWidget {
  final PlayerDetailModel model;

  const PlayerStats({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Position:',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
            SizedBox(height: 8.0), // Spacing between text lines
            Text(
              'Selected by:',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Text(
              'Total Points:',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.player!.position ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 8.0),
            Text(
              "${model.player?.selectionRate?.ceilToDouble() ?? ""}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 8.0),
            Text(
              model.player!.totalScore.toString() ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ],
    );
  }
}
