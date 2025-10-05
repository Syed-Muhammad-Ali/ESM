import 'package:european_single_marriage/core/utils/constant/app_images.dart';
import 'package:european_single_marriage/model/profile_model.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<ProfileModel> user =
      ProfileModel(
        name: 'Teja Khan',
        phone: '03426661888',
        email: 'teja124@gmail.com',
        image: AppImages.imageURL,
      ).obs;
}
