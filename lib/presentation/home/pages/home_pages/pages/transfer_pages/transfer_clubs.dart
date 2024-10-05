import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/app_colors.dart';
import '../../controllers/transfer_page_controller.dart';

class TransferCubs extends StatelessWidget {
  final TransferPageController transfer;

  const TransferCubs({super.key, required this.transfer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 241, 241, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                )),
            Text(
              "Barcha o'yinchilar".tr,
              style: CustomStyles.pageTitle,
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.tableColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(AppColors.tableColor),
              dataRowHeight: 60,
              columnSpacing: 60,
              columns: [
                DataColumn(
                    label: Text(
                  "Klub".tr,
                  style: CustomStyles.dataTitle,
                )),
                DataColumn(
                    label: Text(
                  "Narxi".tr,
                  style: CustomStyles.dataTitle,
                )),
              ],
              rows: List.generate(
                transfer.playersDetails.length,
                (index) {
                  var player = transfer.playersDetails[index];
                  return DataRow(
                      color: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                          // Set the color of the row to black
                          return AppColors.tableColor;
                        },
                      ),
                      cells: [
                        DataCell(GestureDetector(
                          onTap: () {
                            transfer.buyPlayer(player);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150.w,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        "assets/images/home/circle.png",
                                        width: 8,
                                        fit: BoxFit.cover,
                                      ),
                                      if (player.clubLogo != null)
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: CachedNetworkImage(
                                            imageUrl: player.clubLogo!,
                                            width: 23.w,
                                            height: 27.h,
                                            placeholder: (context, url) {
                                              return Image.asset(
                                                "assets/images/home/player_img.png",
                                                width: 30.w,
                                                height: 30.h,
                                              );
                                            },
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              "assets/images/home/player_img.png",
                                              width: 30.w,
                                              height: 30.h,
                                            ),
                                          ),
                                        ),
                                      SizedBox(
                                        width: 110.w,
                                        child: Text(
                                          player.name!,
                                          style: CustomStyles.dataTitle!
                                              .copyWith(
                                                  overflow: TextOverflow.fade),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        DataCell(Text("\$ ${player.price}",
                            style: CustomStyles.dataTitle)),
                      ]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
