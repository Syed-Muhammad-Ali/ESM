import 'package:european_single_marriage/core/common/custam_container.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:flutter/material.dart';

class AuthLogin extends StatelessWidget {
  final String bgImage;
  final Widget child;
  final GlobalKey<FormState>? formKey;
  const AuthLogin({
    super.key,
    required this.child,
    required this.bgImage,
    this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      // height: 50,
      width: double.infinity,
      imageDecoration: DecorationImage(
        image: AssetImage(bgImage),
        fit: BoxFit.fill,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Color(0x99000000), Color(0x66000000)],
          ),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: AppSizes.paddingSH,
                          right: AppSizes.paddingSH,
                          top: AppSizes.spaceMd,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                        ),
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
