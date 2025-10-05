import 'package:european_single_marriage/controller/home%20controller/fqa_controller.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpSupportScreen extends StatelessWidget {
  final HelpSupportController controller = Get.put(HelpSupportController());

  HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Column(
        children: [
          Container(
            width: double.infinity,

            color: AppColors.appBarColor,
            child: SafeArea(
              child: AppBar(
                backgroundColor: AppColors.appBarColor,
                leading: BackButton(),
                centerTitle: true,
                title: const CustomText(
                  title: "Help & Support",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSV,
                vertical: AppSizes.paddingSV,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    title: "How Can We Help?",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  AppSizes.xs.heightBox,
                  const CustomText(
                    title:
                        "Find answers to common questions or contact our support team.",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4B5563),
                  ),
                  AppSizes.spaceBtwSections.heightBox,

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: Column(
                      children: [
                        supportOption("Contact Support"),
                        buildDivider(),
                        supportOption("Report Abuse"),
                        buildDivider(),
                        supportOption("FAQ Section"),
                        buildDivider(),
                        supportOption("App Feedback Form"),
                      ],
                    ),
                  ),
                  24.heightBox,

                  const CustomText(
                    title: "Popular FAQs",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  AppSizes.spaceBtwItems.heightBox,
                  Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.faqs.length,
                        separatorBuilder: (context, index) => buildDivider(),
                        itemBuilder: (context, index) {
                          final faq = controller.faqs[index];
                          return Theme(
                            data: Theme.of(
                              context,
                            ).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              title: CustomText(
                                title: faq.question,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              trailing: Icon(
                                faq.isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 22,
                                color: AppColors.iconColor,
                              ),
                              onExpansionChanged: (_) {
                                controller.toggleFaq(index);
                              },
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: CustomText(
                                    title: faq.answer,
                                    fontSize: 13,
                                    color: AppColors.gray1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget supportOption(String title) {
    return ListTile(
      title: CustomText(
        title: title,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: AppColors.iconColor,
      ),
      onTap: () {},
    );
  }

  Widget buildDivider() {
    return const Divider(thickness: 1, color: AppColors.orange, height: 0);
  }
}
