import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/img_roots.dart';
import '../controllers/rating_page_controller.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final controller = Get.find<RatingPageController>();

  @override
  void initState() {
    super.initState();
    controller.getRating();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Reyting".tr,
          style: CustomStyles.appBarStyle,
        ),
        leading: IconButton(
          onPressed: () {
//   Navigator.pop(context);
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Positioned(
              top: 0,
              child: Image.asset(
                ImgRoots.bg3,
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
          ),
          GetBuilder<RatingPageController>(builder: (_) {
            return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 5),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                  child: Stack(
                    children: [
                      DataTable(
                        headingRowColor: WidgetStateProperty.all(
                          Colors.white,
                        ),
                        dataRowHeight: 40,
                        columnSpacing: 3,
                        dividerThickness: 0,
                        decoration: BoxDecoration(
                          color: AppColors.lGrey,
                        ),
                        columns: [
                          DataColumn(
                              label: Text(
                            "Pos".tr,
                            style: CustomStyles.dataTitle!
                                .copyWith(color: AppColors.purple),
                          )),
                          DataColumn(
                              label: Text(
                            "Klub".tr,
                            style: CustomStyles.dataTitle!
                                .copyWith(color: AppColors.purple),
                          )),
                          DataColumn(
                              label: Text(
                            "Shu tur".tr,
                            style: CustomStyles.dataTitle!
                                .copyWith(color: AppColors.purple),
                          )),
                          DataColumn(
                              label: Text(
                            " All PTS",
                            style: CustomStyles.dataTitle!
                                .copyWith(color: AppColors.purple),
                          )),
                        ],
                        rows: List.generate(
                          controller.teams.length,
                          (index) {
                            var user = controller.teams[index];
                            return DataRow(
                                color: WidgetStateProperty.resolveWith<Color?>(
                                  (Set<WidgetState> states) {
                                    return AppColors.lGrey;
                                  },
                                ),
                                cells: [
                                  DataCell(Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text((index + 1).toString(),
                                            style: CustomStyles.dataTitle!
                                                .copyWith(color: Colors.black)),
                                      ),
                                    ],
                                  )),
                                  DataCell(GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 150.w,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      user.name!,
                                                      style: CustomStyles
                                                          .dataTitle!
                                                          .copyWith(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.black,
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                  DataCell(Text(user.currentScore.toString(),
                                      style: CustomStyles.dataTitle!
                                          .copyWith(color: Colors.black))),
                                  DataCell(Row(
                                    children: [
                                      Row(

                                        children: [
                                          VerticalDivider(),
                                          SizedBox(width: 12.w,),
                                          Text(user.totalScore.toString(),
                                              style: CustomStyles.dataTitle!
                                                  .copyWith(color: Colors.black)),
                                        ],
                                      ),
                                    ],
                                  )),
                                ]);
                          },
                        ),
                      ),

                      Column(
                        children: List.generate(
                          controller.teams.length + 1,
                          (index) {
                            Color containerColor;
                            if (index == 1) {
                              containerColor = AppColors.green1;
                            } else if (index >= 2 && index <= 4) {
                              containerColor = AppColors.baseColor;
                            } else if (index >= 5 && index <= 6) {
                              containerColor =AppColors.yellow;
                            } else if (index >= 7 && index <= 12) {
                              containerColor = AppColors.cyan;
                            } else {
                              containerColor = AppColors.red2;
                            }
                            return index == 0
                              ? SizedBox(
                                  height: 56.h,
                                )
                              : Container(
                                  // margin: EdgeInsets.only(bottom:  4), // Offset based on row height and margin
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 3.5),
                                  // Offset based on row height and margin
                                  height: 33,
                                  width: 5,
                                  decoration:  BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      color: containerColor),
                                );

                          },
                        ),
                      ),
                    ],
                  )),
            ));
          })
        ],
      ),
    );
  }
}
