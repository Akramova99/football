import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/models/team_model.dart';
import 'package:football/presentation/home/pages/statistics/controllers/statistics_page_controller.dart';
import 'package:get/get.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../my_team_controller.dart';

class MyTeamPlayerField extends StatefulWidget {
  final Player player;

  final void Function()? onInitPlayer;
  final TeamModel? myTeam;

  const MyTeamPlayerField({
    super.key,
    this.myTeam,
    this.onInitPlayer,
    required this.player,

  });

  @override
  State<MyTeamPlayerField> createState() => _PointsPlayerWidget1State();
}

class _PointsPlayerWidget1State extends State<MyTeamPlayerField> {
  _onInitPlayer() {
    if (widget.onInitPlayer != null) {
      widget.onInitPlayer!();
    }
  }

  @override
  void initState() {
    super.initState();
    _onInitPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyTeamController>();
    final controller2 = Get.find<StatisticsPageController>();

    return GetBuilder<MyTeamController>(
      builder: (_) {
        //  Logger().d(controller.isOne);
        controller2.getPlayers(widget.player.id ?? 2);
        return Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(5),
          height: 75.h,
          width: controller.isOne ? 55.w : 60.w,
          decoration: BoxDecoration(
            color: AppColors.purple.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: widget.player.name != null
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    if (widget.player.isCapitan ?? false)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 50.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(125, 115, 115, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              widget.player.isCapitan! ? "C" : "",
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: CupertinoColors.white),
                            ),
                          ),
                        ],
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.player.jersey != null
                            ? Flexible(
                                child: CachedNetworkImage(
                                  imageUrl: widget.player.jersey!,
                                  width: 60.w,
                                  height: 54.h,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Image.asset(
                                    "assets/images/home/player_img.png",
                                    width: 40,
                                  ),
                                ),
                              )
                            : Image.asset(
                                "assets/images/home/player_img.png",
                                width: 40,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                      ],
                    ),
                    Container(
                      width: 60.w,
                      //   alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                height: 15.h,
                                width: 12.w,
                                alignment: Alignment.center,
                                color: const Color.fromRGBO(55, 0, 60, 1),
                                child: Text(
                                  "${widget.player.totalScore ?? ""}",
                                  style: const TextStyle(
                                      fontSize: 7, color: Colors.white),
                                ),
                              )),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  height: 15.h,
                                  alignment: Alignment.center,
                                  color: widget.player.name != null
                                      ? CupertinoColors.white
                                      : Colors.transparent,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      widget.player.name ?? "",
                                      style: const TextStyle(
                                          color: CupertinoColors.black,
                                          fontSize: 5),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          Container(
                            height: 10.h,
                            color: Colors.white,
                            child: const Center(
                              child: Text(
                                "MCI(A)",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(20),
                  height: 65.h,
                  width: 60.w,
                  child: GestureDetector(
                    child: Image.asset(
                      "assets/images/home/player_img.png",
                      fit: BoxFit.cover,
                    ),
                    onTap: () {},
                  ),
                ),
        );
      },
    );
  }
}
