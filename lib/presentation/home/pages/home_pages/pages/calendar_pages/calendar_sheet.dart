import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/styles.dart';
import '../../controllers/calendar_page_controller.dart';

class CalendarSheet extends StatefulWidget {
  const CalendarSheet({
    super.key,
  });

  @override
  State<CalendarSheet> createState() => _PlayerDetailPageState();
}

class _PlayerDetailPageState extends State<CalendarSheet> {
  final controller = Get.find<CalendarPageController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getGameStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<CalendarPageController>(
      builder: (_) {
        return  Scaffold(
          backgroundColor: AppColors.lBlack,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, right: 30),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20,
                            color: Colors.white,
                          )),
                      Spacer(),
                      Text(
                        "Taqvim",
                        style:
                        CustomStyles.pageTitle!.copyWith(color: Colors.white),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Text(
                  "Full time",
                  style: CustomStyles.pageTitle!
                      .copyWith(color: Colors.green, fontSize: 10),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CachedNetworkImage(
                        imageUrl: controller.calendarMatch.homeLogo ?? '', // Fallback to empty string if homeLogo is null
                        width: 65,
                        height: 65,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(
                          "assets/images/home/player_img.png",
                          width: 40,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/images/home/player_img.png",
                          width: 54,
                        ),
                      ),
                      Text(
                        "${controller.calendarMatch.homeFinalScore} - ${controller.calendarMatch.awayFinalScore}",
                        style: CustomStyles.text.copyWith(color: Colors.white),
                      ),
                      CachedNetworkImage(
                        imageUrl:  controller.calendarMatch.awayLogo ?? '',
                        // player.jersey!,
                        width: 65,
                        height: 65,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(
                          "assets/images/home/player_img.png",
                          width: 40,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/images/home/player_img.png",
                          width: 54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:controller.calendarMatch.goalscorers!=null? controller.calendarMatch.goalscorers!.length:0,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // This creates two items per row
                      mainAxisSpacing: 10, // Spacing between rows
                      crossAxisSpacing: 20, // Spacing between columns
                      childAspectRatio: 4, // Adjust this to control the height-to-width ratio
                    ),
                    itemBuilder: (context, index) {
                      var goalscorer = controller.calendarMatch.goalscorers!;
                      String formattedText = "${goalscorer[2]} ${goalscorer[0]}’"; // Format as "De Jong 66’"

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formattedText,
                              style: CustomStyles.text.copyWith(color: Colors.white, fontSize: 10.5),
                            ),
                            // You can add more text or UI elements here if necessary, such as scorerType
                          ],
                        ),
                      );
                    },
                  ),
                ),


                Text(
                  "Statistic Match",
                  style: CustomStyles.text
                      .copyWith(color: Colors.white, fontSize: 14),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var item = controller.calendarMatch.statistics![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${item.home}",
                              style: CustomStyles.text
                                  .copyWith(color: Colors.white, fontSize: 14),
                            ),
                            Text(
                              "${item.type}",
                              style: CustomStyles.popText
                                  .copyWith(color: AppColors.textColor),
                            ),
                            Text(
                              "${item.away}",
                              style: CustomStyles.text
                                  .copyWith(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount:controller.calendarMatch.statistics!=null? controller.calendarMatch.statistics!.length:0)
              ],
            ),
          ),
        );
      },
    )
     ;
  }
}
