import 'package:football/presentation/home/pages/home_pages/pages/calendar_pages/calendar_page.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues_page.dart';
import 'package:football/presentation/home/pages/home_pages/pages/my_team_page.dart';
import 'package:football/presentation/home/pages/home_pages/pages/points_page.dart';
import 'package:football/presentation/home/pages/home_pages/pages/transfer_page.dart';

const intro = [
  {
    'image': "assets/images/intro/intro_img_1.png",
    "title": "Futbol o'yini",
    "text": "Professional liga futbol uchrashuvlarini tomosha qiling va o’ynang"
  },
  {
    'image': "assets/images/intro/intro_img_2.png",
    "title": ""
        "Real vaqt statistikasi",
    "text":
        "105 mln ga 15 nafar uyinchini sotib oling va ularning xakikiy uyinlardagi xarakatlari uchun ochkolarni kulga kiriting. Xush, orzuingizdagi jamoaga kimlarni olasiz?"
  },
  {
    'image': "assets/images/intro/intro_img_3.png",
    "title": "Liga turnir jadvali",
    "text": "Butun dunyo bo'ylab klublar statistikasi va ligadagi holati"
  },
];

const List bottomNavigation = [
  {"image": "assets/images/bottom_navigation/home_bottom.png", "label": "Home"},
  {
    "image": "assets/images/bottom_navigation/balance_bottom.png",
    "label": "Balance"
  },
  {
    "image": "assets/images/bottom_navigation/statistics_bottom.png",
    "label": "Statistics"
  },
  {
    "image": "assets/images/bottom_navigation/settings_bottom.png",
    "label": "Settings"
  },
];

const List homeMenuItems = [
  {
    "image": "assets/images/home/m_points_img.png",
    "label": "Ochkolar",
    "rout": PointsPage()
  },
  {
    "image": "assets/images/home/m_team_img.png",
    "label": "Mening Jamoam",
    "rout": MyTeamPage()
  },
  {
    "image": "assets/images/home/m_taqvim_img.png",
    "label": "Taqvim",
    "rout": CalendarPage()
  },
  {
    "image": "assets/images/home/m_transfer_img.png",
    "label": "Transfer",
    "rout": TransferPage()
  },
  {
    "image": "assets/images/home/m_leagues_img.png",
    "label": "Ligalar",
    "rout": LeaguesPage()
  },
];

const List settingMenuItems = [
  {
    "image": "assets/images/settings/language_img.png",
    "label": "Tilni Tanlang",
    "rout": ""
  },
  {
    "image": "assets/images/settings/intro_img.png",
    "label": "Tanishtiruv",
    "rout": ""
  },
  {
    "image": "assets/images/settings/profile.png",
    "label": "Profile",
    "rout": ""
  },
  {
    "image": "assets/images/settings/notification_img.png",
    "label": "Bildirishnomalar",
    "rout": ""
  },
  {
    "image": "assets/images/settings/share_img.png",
    "label": "Ilovani ulashish",
    "rout": ""
  },
  {
    "image": "assets/images/settings/invite_friends_img.png",
    "label": "Do'stlarni taklif qiling",
    "rout": ""
  },
];

var tactics = [
  [1, 3, 4, 3],
  [1, 3, 5, 2],
  [1, 4, 5, 1],
  [1, 4, 4, 2]
];

var tacticsString = ['1-3-4-3', '1-3-5-2', '1-4-5-1', '1-4-4-2'];

Map<int, String> reversePosition = {
  0: "goalkeeper",
  1: "defender",
  2: "midfielder",
  3: "forward",
};
