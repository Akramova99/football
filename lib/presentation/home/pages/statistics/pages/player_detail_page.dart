import 'package:flutter/material.dart';
import 'package:football/utils/constants/styles.dart';

import '../../../../../models/team_model.dart';

class PlayerDetailPage extends StatelessWidget {
  const PlayerDetailPage({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Player profile",
          style: CustomStyles.pageTitle,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 150,
                      child: Image.network(
                        player.jersey!,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: Text(
                                  "Name: ",
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  player.name!,
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: Text(
                                  "Club: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  player.clubName!,
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: Text(
                                  "Price: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  "\$${player.price.toString()}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 3,
                                child: Text(
                                  "Position: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  player.position!,
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
