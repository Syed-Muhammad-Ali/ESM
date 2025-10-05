import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt selectedIndex = 0.obs;
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
  static DashboardController get to => Get.find<DashboardController>();
}
