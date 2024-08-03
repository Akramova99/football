import 'package:flutter/services.dart';
import 'package:football/presentation/widgets/toast.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendsController extends GetxController {
  String? leaguePassword;
  String? leagueLink;

  getData() {
    leaguePassword = "61DWKPEX03";
    leagueLink = "https://translate.google..";
  }

  share() async {
    await Share.share('check out my website https://example.com',
        subject: 'Look what I made!');
  }

  copyText() async {
    await Clipboard.setData(ClipboardData(text: "your text"));
    ToastService.showSuccess("Copied");
  }
}
