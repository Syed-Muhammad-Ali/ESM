import 'package:european_single_marriage/core/common/main_button.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SomethingWrong extends StatelessWidget {
  const SomethingWrong({
    super.key,
    required this.onTapRetry,
    required this.message,
  });
  final Function? onTapRetry;
  final String message;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * (0.025)),
          SizedBox(
            height: MediaQuery.of(context).size.height * (0.28),
            child: SvgPicture.asset('assets/images/somethingWentWrong.svg'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * (0.025)),
          const Padding(
            padding: EdgeInsets.only(left: 18, right: 18),
            child: Text(
              'Something went wrong. Please try again later.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.black, fontSize: 16),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.red, fontSize: 14),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * (0.04)),
          MainButton(
            title: "Retry",
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.4,
            onPressed: () {
              onTapRetry?.call();
            },
          ),
        ],
      ),
    );
  }
}
