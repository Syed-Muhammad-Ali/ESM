import 'package:european_single_marriage/core/utils/constant/app_images.dart';
import 'package:european_single_marriage/model/matches_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchesDetailsController extends GetxController {
  final Rx<MatchesModel> matchDetails =
      MatchesModel(
        name: 'N. Meera',
        age: 23,
        height: '5’4”',
        education: 'MCA',
        location: 'Bangalore',
        profession: 'UI Designer',
        imageList: [AppImages.imageURL, AppImages.imageURL, AppImages.imageURL],
        usePageView: true,
      ).obs;

  RxInt pageIndex = 0.obs;
  PageController pageController = PageController();



}
