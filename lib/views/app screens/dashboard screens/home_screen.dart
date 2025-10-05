import 'package:european_single_marriage/controller/home%20controller/home_controller.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_images.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/data/response/status.dart';
import 'package:european_single_marriage/model/user_model.dart';
import 'package:european_single_marriage/views/screens%20widgets/home%20Widget/search_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeCtrl = Get.put(HomeController());
    final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    homeCtrl.currentUser = homeCtrl.user.value;

    // automatically load all lists
    homeCtrl.fetchAllMatches();
    homeCtrl.fetchSameCasteMatches();
    homeCtrl.fetchNearLocationMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: SafeArea(
        child: Obx(() {
          if (homeCtrl.rxRequestStatus.value == Status.LOADING) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = homeCtrl.users.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingSH,
                  vertical: AppSizes.md,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(AppImages.imageURL),
                    ),
                    AppSizes.sm.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          title: "Welcome,",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey3,
                        ),
                        CustomText(
                          title: "Ijaz",
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset("assets/images/bell.png", height: 28),
                        // const Icon(
                        //   Icons.notifications_none,
                        //   size: 36,
                        //   color: AppColors.orange,
                        // ),
                        if (homeCtrl.notifications.value > 0)
                          Positioned(
                            right: -3,
                            top: -8,
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor: AppColors.primaryColor,
                              child: CustomText(
                                title: homeCtrl.notifications.value.toString(),
                                fontSize: 10,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSizes.spaceBtwItems.heightBox,

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingSH,
                        vertical: AppSizes.paddingSV,
                      ),
                      child: Column(
                        children: [
                          SearchField(
                            controller: searchController,
                            onChanged: (value) => homeCtrl.searchUsers(value),
                          ),

                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF2E5),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x40A4A4A4),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    AppImages.imageURL,
                                  ),
                                  radius: 25,
                                ),
                                AppSizes.sm.widthBox,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                        title:
                                            "Oops! Your profile is inprogress. \nComplete now to get more matches",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF323232),
                                      ),

                                      AppSizes.sm.heightBox,
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 120,
                                        ),
                                        child: Stack(
                                          children: [
                                            LinearProgressIndicator(
                                              minHeight: 13.0,
                                              value: users.profileCompletion,
                                              backgroundColor: AppColors.grey,
                                              color: AppColors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            Positioned(
                                              left: 17,
                                              bottom: 0,
                                              child: CustomText(
                                                title:
                                                    '${homeCtrl.profileCompletion.value}%',
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      AppSizes.sm.heightBox,
                                      const CustomText(
                                        title: "Complete Now",
                                        color: AppColors.blue,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        textDecoration:
                                            TextDecoration.underline,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppSizes.spaceBtwItems.heightBox,

                          GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.2,
                            children: [
                              statCard(
                                "Viewed You",
                                users.viewedYou,
                                Color(0xFF89A6F0),
                                "assets/images/eye.png",
                              ),
                              statCard(
                                "Sent Request",
                                users.sentRequests,
                                Color(0xFFFFC969),
                                "assets/images/send.png",
                              ),
                              statCard(
                                "Received Request",
                                users.receivedRequests,
                                Color(0xFFFC72AA),
                                "assets/images/rreceivedequest.png",
                              ),
                              statCard(
                                "Request Accepted",
                                users.acceptedRequests,
                                Color(0xFF47E76F),
                                "assets/images/tick.png",
                              ),
                            ],
                          ),

                          AppSizes.spaceBtwItems.heightBox,
                          RecomendedCardWidget(
                            title: "Recommended Matches",
                            usersList: homeCtrl.sameCasteMatches.value,
                            searchQuery: homeCtrl.searchQuery.value,
                          ),
                          AppSizes.spaceBtwItems.heightBox,
                          RecomendedCardWidget(
                            title: "Near Your Location",
                            usersList: homeCtrl.nearLocationMatches.value,
                            searchQuery: homeCtrl.searchQuery.value,
                          ),
                          AppSizes.spaceBtwItems.heightBox,
                          RecomendedCardWidget(
                            title: "All Matches",
                            showActionButton: true,
                            usersList: homeCtrl.allMatches.value,
                            searchQuery: homeCtrl.searchQuery.value,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget statCard(String title, int count, Color color, String icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: -45,
            right: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0x1AFFFFFF),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Image.asset(icon, height: 15, width: 15),
                ),
              ),

              CustomText(
                title: count.toString(),
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),

              CustomText(
                title: title,
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RecomendedCardWidget extends StatelessWidget {
  final String title;
  final String buttonTitle;
  final bool showActionButton;
  final VoidCallback? onTap;
  final List<UserModel> usersList;
  final String searchQuery;

  const RecomendedCardWidget({
    super.key,
    required this.title,
    this.onTap,
    this.showActionButton = false,
    this.buttonTitle = "View All",
    required this.usersList,
    this.searchQuery = "",
  });

  @override
  Widget build(BuildContext context) {
    final hasSearch = searchQuery.isNotEmpty;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.paddingSV,
        horizontal: AppSizes.md,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CustomText(
                  title: title,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.black,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (showActionButton && buttonTitle.isNotEmpty)
                TextButton(
                  onPressed: onTap,
                  child: CustomText(
                    title: buttonTitle,
                    fontSize: 12,
                    color: AppColors.blue,
                    textDecoration: TextDecoration.underline,
                  ),
                ),
            ],
          ),
          AppSizes.sm.heightBox,
          SizedBox(
            height: 140,
            child:
                usersList.isEmpty
                    ? Center(
                      child: Text(
                        hasSearch
                            ? 'No matches found for "$searchQuery"'
                            : "No matches found",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    )
                    : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: usersList.length,
                      separatorBuilder:
                          (context, index) => AppSizes.md.widthBox,
                      itemBuilder: (context, index) {
                        final user = usersList[index];
                        final imageUrl =
                            (user.profileImages != null &&
                                    user.profileImages!.isNotEmpty)
                                ? user.profileImages!.first
                                : "assets/images/imageURL.jpg";
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    "assets/images/imageURL.jpg",
                                    width: 135,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    width: 135,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Color(0x80000000),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                children: [
                                  Image.network(
                                    imageUrl,
                                    width: 135,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return SizedBox(
                                        width: 135,
                                        height: 150,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.appBarColor,
                                            value:
                                                loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        (loadingProgress
                                                                .expectedTotalBytes ??
                                                            1)
                                                    : null,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                              "assets/images/imageURL.jpg",
                                              width: 135,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                  ),
                                  Container(
                                    width: 135,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Color(0x80000000),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Positioned(
                              bottom: 6,
                              left: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title: user.name ?? "Unknown",
                                    fontSize: 14,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  CustomText(
                                    title: user.occupation ?? "",
                                    fontSize: 11,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
