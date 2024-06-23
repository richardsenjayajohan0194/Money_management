import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentIndexPage = 0;

  void changeCurrentIndexPage(int index) {
    currentIndexPage = index;

    update();
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
