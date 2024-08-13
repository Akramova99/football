import 'package:flutter/material.dart';

import '../../models/player_detail_model.dart';

class PlayerDataTable extends StatelessWidget {
  final PlayerDetailModel model;

  const PlayerDataTable({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            children: const [
              TableRow(
                decoration:
                    BoxDecoration(color: const Color.fromRGBO(51, 231, 51, 1)),
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
                  SizedBox(),
                ],
              ),
              TableRow(
                decoration:
                    BoxDecoration(color: const Color.fromRGBO(77, 254, 77, 1)),
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
                      'Value',
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
              2: FlexColumnWidth(1),
            },
            children: const [
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Minutes Played'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '90',
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '2',
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Assists'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '1',
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '3',
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Clean sheet'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '1',
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '4',
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Every 10 Interceptions and tackles',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '12',
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '1',
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Total',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(''),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '10',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
            ],
          ),
        ],
      ),
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
