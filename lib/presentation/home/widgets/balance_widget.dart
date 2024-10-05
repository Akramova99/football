import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football/services/url_launcher_service.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/styles.dart';
import '../controllers/balance_page_controller.dart';

class BalanceWidget extends StatelessWidget {
  final int index;
  final Function onTap;
  final Color colors;
  final String iconImg;
  final bool isExpanded;
  final bool isLeft; // Identifies if the widget is on the left

  const BalanceWidget({
    super.key,
    required this.index,
    required this.colors,
    required this.onTap,
    required this.iconImg,
    this.isExpanded = false,
    this.isLeft = true, // Default to left side
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BalancePageController>();
    Alignment alignment = isLeft ? Alignment.centerLeft : Alignment.centerRight;

    return GetBuilder<BalancePageController>(builder: (_) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: isExpanded ? 311.w : 150.w,
        // Adjust width dynamically
        height: 127.h,
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        alignment: alignment,
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(6),
        ),
        child: InkWell(
          onTap: () {
            onTap();
            controller.postPayment(controller.packets[index].name!);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/balance/$iconImg.png",
                    height: 24,
                  ),
                  Row(
                    children: [
                      isExpanded
                          ? Text(
                              "${controller.packets.isNotEmpty ? controller.packets[index].coinValue : ""}\$",
                              style: CustomStyles.appBarStyle,
                            )
                          : SizedBox(),
                      Image.asset(
                        "assets/images/balance/star.png",
                        height: 24,
                        color: iconImg == "price"
                            ? Color(0xff929393)
                            : Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.packets.isNotEmpty ? controller.packets[index].numberOfTransfers : ""} ${"ta Transfer".tr}",
                        style: CustomStyles.dataTitle!.copyWith(
                          color:
                              iconImg == "price" ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${"Sotish ".tr}-30%",
                        style: CustomStyles.dataTitle!.copyWith(
                          color: iconImg == "price"
                              ? Color(0xff929393)
                              : Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  // Spacer to separate text from the button
                  Spacer(),
                  // Use Expanded to allow the Checkout button to expand
                  Expanded(
                    child: isExpanded
                        ? InkWell(
                        onTap: () async {
                        UrlBrowser.launchInBrowser(controller.paymentUrl);
                        },

                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.cyan,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: FittedBox(
                                fit: BoxFit
                                    .scaleDown, // Scales the text if needed
                                child: Text(
                                  "Checkout",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
