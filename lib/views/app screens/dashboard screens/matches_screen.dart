import 'package:european_single_marriage/controller/home%20controller/matches_controller.dart';
import 'package:european_single_marriage/core/common/custam_container.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/data/connectivity/no_internet_connection-warning.dart';
import 'package:european_single_marriage/data/connectivity/somethingWrong.dart';
import 'package:european_single_marriage/data/response/status.dart';
import 'package:european_single_marriage/services/network_service.dart';
import 'package:european_single_marriage/views/screens%20widgets/home%20Widget/match_card.dart';
import 'package:european_single_marriage/views/screens%20widgets/home%20Widget/search_field.dart';
import 'package:european_single_marriage/views/screens%20widgets/home%20Widget/selected_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final matchCtrl = Get.put(MatchesController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      matchCtrl.fetchUsers();
    });
  }

  Future<void> onRefresh() async {
    await matchCtrl.fetchUsers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Obx(() {
        switch (matchCtrl.rxRequestStatus.value) {
          case Status.LOADING:
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );

          case Status.ERROR:
            final error = matchCtrl.errorMessage.value;

            if (error.contains('No internet') ||
                error.contains('SocketException')) {
              return NoInternet(
                onTapRetry: () async {
                  if (await NetworkService.isConnected()) {
                    matchCtrl.fetchUsers();
                  }
                },
              );
            }

            return SomethingWrong(
              message: error,
              onTapRetry: () => matchCtrl.fetchUsers(),
            );

          case Status.COMPLETED:
            final users = matchCtrl.usersData.value;

            if (users.isEmpty) {
              return const Center(child: Text("No Coupons found"));
            }

            return RefreshIndicator(
              backgroundColor: AppColors.white,
              color: AppColors.primaryColor,
              onRefresh: onRefresh,
              child: Column(
                children: [
                  CustomContainer(
                    padding: EdgeInsets.only(top: AppSizes.lg),
                    color: AppColors.appBarColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingSH,
                        vertical: AppSizes.paddingSV,
                      ),
                      child: SearchField(),
                    ),
                  ),
                  AppSizes.spaceBtwItems.heightBox,
                  SelectedTabBar(tabs: matchCtrl.tabs),
                  AppSizes.spaceBtwItems.heightBox,
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: matchCtrl.usersData.value.length,
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          final match = matchCtrl.usersData.value[index];
                          return MatchCard(match: match);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}
