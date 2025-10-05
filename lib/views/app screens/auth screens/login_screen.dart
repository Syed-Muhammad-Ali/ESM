import 'package:european_single_marriage/controller/auth%20controller/auth_controller.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/common/custom_textfield.dart';
import 'package:european_single_marriage/core/common/main_button.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_images.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/routes/app_routes.dart';
import 'package:european_single_marriage/views/screens%20widgets/auth%20widget/auth_login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final authCtrl = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLogin(
      bgImage: AppImages.login,
      formKey: _formKey,
      child: Column(
        children: [
          AppSizes.spaceBtwItems.heightBox,
          CustomText(
            title: "Login to your Account",
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
          AppSizes.spaceMd.heightBox,
          CustomTextField(
            title: "Please enter email",
            hintText: "",
            keyboardType: TextInputType.emailAddress,
            controller: authCtrl.loginUserEmail.value,
            validator:
                MultiValidator([
                  RequiredValidator(errorText: "Please enter your email"),
                  EmailValidator(errorText: "Please enter a valid email"),
                ]).call,
          ),
          CustomTextField(
            title: "Please enter password",
            controller: authCtrl.loginPassword.value,
            keyboardType: TextInputType.name,
            hintText: '',
            obscureText: authCtrl.isPasswordHidden,
            validator:
                MultiValidator([
                  RequiredValidator(errorText: "Please enter your password"),
                  MinLengthValidator(
                    8,
                    errorText: "Password must be at least 8 characters long",
                  ),
                ]).call,
          ),

          AppSizes.spaceMd.heightBox,
          Obx(
            () => MainButton(
              title: "Login",
              loading: authCtrl.loading.value,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  authCtrl.login();
                }
              },
            ),
          ),
          AppSizes.xxl.heightBox,
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.subTitleColors,
              ),
              children: [
                const TextSpan(text: "Don’t have an account?  "),
                TextSpan(
                  text: "Sign Up",
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(AppRoutes.registerScreen);
                        },
                ),
                const TextSpan(text: "  here"),
              ],
            ),
          ),
          AppSizes.spaceBtwItems.heightBox,
        ],
      ),
    );
  }
}
