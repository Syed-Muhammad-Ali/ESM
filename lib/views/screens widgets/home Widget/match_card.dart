import 'package:european_single_marriage/controller/home%20controller/matches_controller.dart';
import 'package:european_single_marriage/core/common/custam_container.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/common/custom_toggle_selector.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/model/user_model.dart';
import 'package:european_single_marriage/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchCard extends StatefulWidget {
  final UserModel match;

  const MatchCard({super.key, required this.match});

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final match = widget.match;
    final images = match.profileImages ?? [];
    final bool hasMultipleImages = images.length > 1;

    return CustomContainer(
      // fun: () => Get.toNamed(AppRoutes.matchesDetails),
      fun: () {
        final matchCtrl = Get.find<MatchesController>();
        matchCtrl.matchDetails.value = widget.match; // 👈 store selected user
        Get.toNamed(AppRoutes.matchesDetails);
      },

      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      cir: 10,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasMultipleImages) ...[
            SizedBox(
              height: 250,
              child: PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                            height: 250,
                            width: double.infinity,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    const Icon(Icons.error, size: 50),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            images.length,
                            (dotIndex) => AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    _currentIndex == dotIndex
                                        ? const Color(0xFFFFA451)
                                        : const Color(0xFFD9D9D9),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ] else if (images.isNotEmpty) ...[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    images.first,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.error, size: 50),
                  ),
                ),
                Positioned(
                  bottom: -2,
                  left: 0,
                  child: Stack(
                    children: [
                      Image.asset("assets/images/container.png"),
                      const Positioned(
                        bottom: 0,
                        left: 40,
                        child: Text('Last seen 2m ago'),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Icons.favorite_border,
                      color: Color(0xFFCFCFCF),
                    ),
                  ),
                ),
              ],
            ),
          ],

          // 🔥 User details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizes.spaceBtwItems.heightBox,
                CustomText(
                  title: match.name ?? "",
                  color: AppColors.titleColor2,
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                ),
                AppSizes.spaceSm.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iTRow(
                      icon: "assets/images/age.png",
                      text: '${match.age ?? "-"} yrs',
                    ),
                    circle(),
                    iTRow(
                      icon: "assets/images/height.png",
                      text: match.height ?? "-",
                    ),
                    circle(),
                    iTRow(
                      icon: "assets/images/education.png",
                      text: match.education ?? "-",
                    ),
                  ],
                ),
                AppSizes.spaceBtwItems.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    iTRow(
                      icon: "assets/images/location.png",
                      text:
                          match.city ??
                          match.state ??
                          match.workLocation ??
                          "-",
                    ),
                    circle(),
                    iTRow(
                      icon: "assets/images/job.png",
                      text: match.occupation ?? "-",
                    ),
                  ],
                ),
                AppSizes.spaceBtwItems.heightBox,
                AppSizes.spaceSm.heightBox,
                CustomToggleSelector(
                  title: "Interested with this profile?",
                  options: ['Yes, Interested', 'No'],
                  selectedValue:
                      Get.find<MatchesController>().profileInterested,
                  onChanged:
                      (value) =>
                          Get.find<MatchesController>()
                              .profileInterested
                              .value = value,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget iTRow({required String icon, required String text}) {
    return Row(
      children: [
        Image.asset(icon, height: 17),
        AppSizes.xs.widthBox,
        CustomText(
          title: text,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF6D6D6D),
        ),
      ],
    );
  }

  Widget circle() {
    return const CircleAvatar(backgroundColor: AppColors.grey, radius: 5);
  }
}
