import 'package:flutter/material.dart';
import 'package:football/utils/constants/app_colors.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:football/utils/constants/test.dart';

import '../../models/match_model.dart';

class MatchListView extends StatelessWidget {
  final List<MatchModel> matches;

  const MatchListView({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    return matches.isNotEmpty
        ? Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ListView.builder(
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final match = matches[index];
                  return Container(
                    height: 50,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: AppColors.lBlack,
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.grey.shade200, width: 2)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Text(
                                  match.home!.teamName!,
                                  style: CustomStyles.dataTitle,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: match.home!.logo == null
                                    ? Image.asset(getRandomTeamLogo())
                                    : Image.network(match.home!.logo!),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                            width: 39,
                            child: Text(
                              "${match.startTime}",
                              style: CustomStyles.dataTitle,
                              maxLines: 1,
                            )),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: match.away!.logo == null
                                    ? Image.asset(getRandomTeamLogo())
                                    : Image.network(match.away!.logo!),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Text(
                                  match.away!.teamName!,
                                  style: CustomStyles.dataTitle,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        : Container(
            width: double.infinity,
            child: const Center(
              child: Text(
                "Hozircha hech qanday matchlar yo'q",
                style: TextStyle(fontSize: 30),
              ),
            ),
          );
  }
}
