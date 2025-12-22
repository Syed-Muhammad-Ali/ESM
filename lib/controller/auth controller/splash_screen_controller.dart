import 'package:european_single_marriage/services/splash_serives.dart';
import 'package:get/get.dart';

class SpalshScreenController extends GetxController {
  SplashServices loginServices = SplashServices();



  @override
  void onInit() {
    super.onInit();
    loginServices.isLogin();
    // Timer(Duration(seconds: 5), () {
    //   Get.offAllNamed(AppRoutes.onBoardingScreen);
    // });
  }
}
