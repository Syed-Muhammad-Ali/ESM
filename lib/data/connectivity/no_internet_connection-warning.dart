import 'package:european_single_marriage/core/common/main_button.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key, required this.onTapRetry});
  final Function? onTapRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * (0.025)),
          SizedBox(
            height: MediaQuery.of(context).size.height * (0.35),
            child: SvgPicture.asset('assets/images/noInternet.svg'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * (0.025)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'No internet! Please check your network connection and try again',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.black, fontSize: 16),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * (0.06)),
          MainButton(
            title: "Retry",
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.4,
            onPressed: () {
             onTapRetry?.call();
            },
          ),
          // AppButton(
          //   height: MediaQuery.of(context).size.height * 0.05,
          //   width: MediaQuery.of(context).size.width * 0.4,
          //   ontap: () {
          //     onTapRetry?.call();
          //   },
          //   label: 'Retry',
          //   txtClr: AppColors.white,
          //   txtSize: 16,
          //   gradient: AppColors.appGradient,
          // ),
        ],
      ),
    );
  }
}
