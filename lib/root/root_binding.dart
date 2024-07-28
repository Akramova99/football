import 'package:football/presentation/home/controllers/base_page_controller.dart';
import 'package:football/presentation/home/controllers/home_page_controller.dart';
import 'package:football/presentation/home/pages/home_pages/controllers/points_page_controller.dart';
import 'package:football/presentation/intro/controllers/create_team_controller.dart';
import 'package:football/presentation/intro/controllers/login_register_controller.dart';
import 'package:football/presentation/intro/controllers/select_team_name_controller.dart';
import 'package:get/get.dart';


class RootBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>SelectTeamNameController(), fenix: true);
    Get.lazyPut(()=>LoginRegisterController(), fenix: true);
    Get.lazyPut(()=>BasePageController(), fenix: true);
    Get.lazyPut(()=>HomePageController(), fenix: true);
    Get.lazyPut(()=>PointsPageController(), fenix: true);
    Get.lazyPut(()=>CreateTeamController(), fenix: true);



  }

}