import 'package:get/get.dart';
import 'package:money_management/app/modules/add_wallate/controllers/add_wallate_controller.dart';
import 'package:money_management/app/modules/home/controllers/home_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController()
    );
    Get.lazyPut<AddWallateController>(() => AddWallateController());
  }
}
