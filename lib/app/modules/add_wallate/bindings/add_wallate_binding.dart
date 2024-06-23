import 'package:get/get.dart';

import '../controllers/add_wallate_controller.dart';

class AddWallateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddWallateController>(
      () => AddWallateController(),
    );
  }
}
