import 'package:flutter/cupertino.dart';
import 'package:football/models/player_selection_model.dart';
import 'package:football/presentation/widgets/player_selection_widget.dart';
import 'package:football/presentation/widgets/points_player_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/team_model.dart';

class PlayersCardWidget extends StatelessWidget {
  final List<PlayerSelectionModel> players;
  final Function function;

  const PlayersCardWidget(
      {super.key, required this.players, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 86.h,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(94, 129, 58, 1),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: players.length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: PlayerWidget(player: players[index])),
              onTap: () {
                function(players[index]);
              },
            );
          }),
    );
  }
}

class PlayersCardWidget2 extends StatelessWidget {
  final List<Player> players;
  final Function function;

  const PlayersCardWidget2(
      {super.key, required this.players, required this.function});

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 265.h,
        child: Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            // GridView o'z elementlariga moslashishi uchun
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Bir qatorga nechta element joylashtirish
              childAspectRatio: 1, // Elementning kengligi va bo'yi nisbati
              crossAxisSpacing: 1, // Gorizontal bo'shliq
              mainAxisSpacing: 10, // Vertikal bo'shliq
            ),
            itemCount: players.length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: (){
                  function(players[index]);
                },
                child: PointsPlayerWidget(
                  player: players[index],
                ),
              );
            },
          ),
        )

      //
      // ListView.builder(
      //   physics: NeverScrollableScrollPhysics(),
      // //  itemExtent: 80,
      //   scrollDirection: Axis.horizontal,
      //   itemCount: players.length,
      //   itemBuilder: (ctx, index) {
      //     return PointsPlayerWidget(
      //       player: players[index],
      //     );
      //   },
      // ),
    );
  }
}

