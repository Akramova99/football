import 'package:flutter/material.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:get/get.dart';

import '../pages/statistics/controllers/statistics_page_controller.dart';

class PlayerStatisticWidget extends StatefulWidget {
  //i need PlayerDetailModel
  final StatisticsPageController controller;
  final int index;

  const PlayerStatisticWidget(
      {super.key, required this.controller, required this.index});

  @override
  State<PlayerStatisticWidget> createState() => _PlayerStatisticWidgetState();
}

class _PlayerStatisticWidgetState extends State<PlayerStatisticWidget> {
  final controller = Get.find<StatisticsPageController>();

  @override
  void initState() {
    super.initState();
    controller.getPlayers(widget.controller.statics[widget.index].playerId!);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatisticsPageController>(builder: (_) {
      return GestureDetector(
        onTap: () {
          widget.controller
              .callPLayerDetailPage(controller.players!, context);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
          height: 145,
          decoration: BoxDecoration(
            color: AppColors.statistic,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.only(top: 22, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 23,
                    width: 20,
                    child: Image.network(
                      controller.statics[widget.index].clubLogo,
                      fit: BoxFit.cover,
                      //color: Colors.white,
                    ),
                  ),
                  Text(
                    //widget.controller.players[widget.index].name??"",
                    controller.statics[widget.index].playerName ?? "",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  ),
                  Text(
                    controller.statics[widget.index].position,
                    style: const TextStyle(
                        fontSize: 8,
                        color: AppColors.textColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    controller.statics[widget.index].playerNumber.toString(),
                    style: const TextStyle(
                        fontSize: 21,
                        color: AppColors.textColor2,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 28.0),
              //   child: CachedNetworkImage(
              //     height: 143,
              //     width: 127,
              //     imageUrl: controller.players.isNotEmpty
              //         ? controller.players[widget.index].jersey!
              //         : "",
              //     placeholder: (context, url) =>
              //         Image.asset('assets/images/team/placeholder.png'),
              //     errorWidget: (context, url, error) => Image.asset(
              //       'assets/images/team/placeholder.png',
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }
}
