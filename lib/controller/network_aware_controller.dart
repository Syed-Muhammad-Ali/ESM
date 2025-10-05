import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/snackBar/snackbar_utils.dart';
import 'package:european_single_marriage/data/response/status.dart';
import 'package:european_single_marriage/services/network_service.dart';
import 'package:get/get.dart';


mixin NetworkAwareController on GetxController {
  Future<bool> checkConnection({
    required Rx<Status> statusController,
    required RxString errorController,
  }) async {
    final connected = await NetworkService.isConnected();
    if (!connected) {
      statusController.value = Status.ERROR;
      errorController.value = "No internet";
      Utils.snackBar(
        "No internet",
        "Please check your connection",
        AppColors.red,
      );
    }
    return connected;
  }
}


// mixin NetworkAwareController on GetxController {
//   Future<bool> checkConnection() async {
//     final connected = await NetworkService.isConnected();
//     if (!connected) {
//       Utils.snackBar(
//         "No internet",
//         "Please check your connection",
//         AppColors.red,
//       );
//     }
//     return connected;
//   }
// }

// Future<bool> checkConnection() async {
//   final connected = await NetworkService.isConnected();
//   if (!connected) {
//     Utils.snackBar("No internet", "Please check your connection", AppColors.red);
//   }
//   return connected;
// }
