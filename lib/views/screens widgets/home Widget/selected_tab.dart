import 'package:european_single_marriage/controller/home%20controller/matches_controller.dart';
import 'package:european_single_marriage/core/common/custom_svg.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/model/tab_items.dart';
import 'package:european_single_marriage/views/screens%20widgets/home%20Widget/match_preferess.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedTabBar extends StatelessWidget {
  final List<TabItems> tabs;
  final bool isInBottomSheet;
  const SelectedTabBar({
    super.key,
    required this.tabs,
    this.isInBottomSheet = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MatchesController>();
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final tabMapping = {
            'Basic Details': 0,
            'Religious Details': 1,
            'Professional Details': 2,
            'Location Details': 3,
            'Family Details': 4,
          };
          return GestureDetector(
            onTap: () {
              if (isInBottomSheet) {
                // ✅ Inside bottom sheet → just switch content
                if (tabMapping.containsKey(tab.text)) {
                  controller.selectTab(tabMapping[tab.text]!);
                }
              } else {
                // ✅ Outside → open bottom sheet at correct tab
                if (tabMapping.containsKey(tab.text)) {
                  final tabIndex = tabMapping[tab.text]!;
                  controller.selectTab(tabIndex); // update current tab
                  _openBottomSheet(context, tabIndex);
                } else {
                  tab.ontap?.call();
                }
              }
            },
            // onTap: () {
            //   if (tab.text == 'Basic Details') {
            //     showModalBottomSheet(
            //       context: context,
            //       isScrollControlled: true,
            //       shape: const RoundedRectangleBorder(
            //         borderRadius: BorderRadius.vertical(
            //           top: Radius.circular(20),
            //         ),
            //       ),
            //       builder: (_) => MatchPreferencesBottomSheet(),
            //     );
            //   } else {
            //     tab.ontap?.call();
            //   }
            // },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (tab.image != null) ...[
                    CustomSvgImage(
                      image: tab.image!,
                      height: 16,
                      width: 16,
                      color: AppColors.black,
                    ),
                    AppSizes.spaceSm.widthBox,
                  ],
                  CustomText(
                    title: tab.text,
                    color: AppColors.black,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _openBottomSheet(BuildContext context, int tabIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => MatchPreferencesBottomSheet(initialTabIndex: tabIndex),
    );
  }
}
