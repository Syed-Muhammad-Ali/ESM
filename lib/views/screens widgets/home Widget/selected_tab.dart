import 'package:european_single_marriage/core/common/custom_svg.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/model/tab_items.dart';
import 'package:european_single_marriage/views/screens%20widgets/home%20Widget/match_preferess.dart';
import 'package:flutter/material.dart';

class SelectedTabBar extends StatelessWidget {
  final List<TabItems> tabs;
  const SelectedTabBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          return GestureDetector(
            onTap: () {
              if (tab.text == 'Match Preference') {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => MatchPreferencesBottomSheet(),
                );
              } else {
                tab.ontap?.call();
              }
            },
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
}
