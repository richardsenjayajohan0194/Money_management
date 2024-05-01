import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_management/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final getStorage = GetStorage();

  final count = 0.obs;

  get isAnimationCompleted => null;
  @override
  void onInit() {
    super.onInit();
    getStorage.write("status", "login");
  }

  @override
  void onReady() {
    super.onReady();
    print("onReady SplashController");
    if (getStorage.read("status") != "" && getStorage.read("status") != null) {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(Routes.LOGIN);
      });
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onClose() {}

  void increment() => count.value++;

}

