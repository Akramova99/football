import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/constants.dart';
import '../../../../../utils/constants/img_roots.dart';
import '../../../../../utils/constants/styles.dart';

class IntroductionGame extends StatelessWidget {
  const IntroductionGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImgRoots.bg1,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        Spacer(),
                        Text(
                          "O\'yin haqida tanishtiruv".tr,
                          style: CustomStyles.appBarStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1, // Matnni bitta qatorda cheklash
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColors.tableColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //
                            Text(
                              "HARAKAT".tr,
                              style: CustomStyles.dataTitle,
                            ),
                            Text(
                              "Ballar".tr,
                              style: CustomStyles.dataTitle,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 600.h,
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
                            headingRowColor:
                                WidgetStateProperty.all(AppColors.tableColor),
                            dataRowHeight: 60,
                            columnSpacing: 0,
                            columns: [
                              DataColumn(
                                label: Text("HARAKAT".tr,
                                    style: CustomStyles.dataTitle),
                              ),
                              DataColumn(
                                label: Text("Ballar".tr,
                                    style: CustomStyles.dataTitle),
                              ),
                            ],
                            rows: List.generate(actions.length, (index) {
                              return DataRow(
                                color: WidgetStateProperty.resolveWith<Color?>(
                                        (Set<WidgetState> states) {
                                      return AppColors.tableColor; // Set the row color
                                    }),
                                cells: [
                                  DataCell(
                                    GestureDetector(
                                      onTap: () {
                                        // Do something when tapped
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/home/circle.png",
                                            width: 8,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              actions[index].tr,
                                              style: CustomStyles.dataTitle!.copyWith(
                                                  overflow: TextOverflow.fade),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      points[index].toString(),
                                      style: CustomStyles.dataTitle,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
