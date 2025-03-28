import 'package:deal_ping/screens/user_screens/user_auth_screens/user_signup_verify_otp_screen/widgets/otp_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_image_path.dart';
import '../../../../constants/app_strings.dart';
import '../../../../widgets/button_widget/button_widget.dart';
import '../../../../widgets/image_widget/image_widget.dart';
import '../../../../widgets/space_widget/space_widget.dart';
import '../../../../widgets/text_button_widget/text_button_widget.dart';
import '../../../../widgets/text_widget/text_widgets.dart';
import 'controller/user_forgot_verify_otp_controller.dart';

class UserForgotVerifyOtpScreen extends StatelessWidget {
  const UserForgotVerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: GetBuilder<UserForgotVerifyAccountController>(
              init: UserForgotVerifyAccountController(),
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SpaceWidget(spaceHeight: 24),
                        const ImageWidget(
                          height: 60,
                          width: 60,
                          imagePath: AppImagePath.appLogoGreen,
                          fit: BoxFit.contain,
                        ),
                        const SpaceWidget(spaceHeight: 125),
                        const Center(
                          child: TextWidget(
                            text: AppStrings.verifyYourAccount,
                            fontColor: AppColors.grey700,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SpaceWidget(spaceHeight: 12),
                        Center(
                          child: TextWidget(
                            text:
                                "${AppStrings.verifyYourAccountDescription} ${controller.email}",
                            fontColor: AppColors.grey300,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SpaceWidget(spaceHeight: 16),
                        Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                OtpInputFieldWidget(
                                    controller:
                                        controller.otpTextEditingController1),
                                OtpInputFieldWidget(
                                    controller:
                                        controller.otpTextEditingController2),
                                OtpInputFieldWidget(
                                    controller:
                                        controller.otpTextEditingController3),
                                OtpInputFieldWidget(
                                    controller:
                                        controller.otpTextEditingController4),
                                OtpInputFieldWidget(
                                    controller:
                                        controller.otpTextEditingController5),
                                OtpInputFieldWidget(
                                  controller:
                                      controller.otpTextEditingController6,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (p0) {
                                    FocusManager.instance.primaryFocus?.unfocus(
                                        disposition: UnfocusDisposition
                                            .previouslyFocusedChild);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SpaceWidget(spaceHeight: 24),
                        Obx(() {
                          return TextWidget(
                            text: controller.canResend.value
                                ? AppStrings.remainingTime
                                : "${AppStrings.resendCodeIn} ${controller.formatTime()}",
                            fontColor: controller.canResend.value
                                ? AppColors.grey
                                : AppColors.grey500,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          );
                        }),
                        const SpaceWidget(spaceHeight: 12),
                        ButtonWidget(
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.verifyOTP();
                              controller.otpTextEditingController1.clear();
                              controller.otpTextEditingController2.clear();
                              controller.otpTextEditingController3.clear();
                              controller.otpTextEditingController4.clear();
                              controller.otpTextEditingController5.clear();
                              controller.otpTextEditingController6.clear();
                            } else if (controller
                                    .otpTextEditingController1.text.isEmpty ||
                                controller
                                    .otpTextEditingController2.text.isEmpty ||
                                controller
                                    .otpTextEditingController3.text.isEmpty ||
                                controller
                                    .otpTextEditingController4.text.isEmpty ||
                                controller
                                    .otpTextEditingController5.text.isEmpty ||
                                controller
                                    .otpTextEditingController6.text.isEmpty) {
                              // CustomToast.showToast("Please fill all fields");
                            }
                          },
                          label: AppStrings.verify,
                          buttonWidth: double.infinity,
                          buttonHeight: 56,
                          backgroundColor: AppColors.green500,
                        ),
                        const SpaceWidget(spaceHeight: 12),
                        Obx(() {
                          // Debugging check
                          if (controller.canResend.value) {
                            print("Resend Code Button is now visible!");
                          }
                          return controller.canResend.value
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const TextWidget(
                                        text: AppStrings.didntReceiveCode,
                                        fontColor: AppColors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        maxLines: 1,
                                      ),
                                      const SpaceWidget(spaceWidth: 6),
                                      TextButtonWidget(
                                        onPressed: () {
                                          controller.resendCode();
                                        },
                                        text: AppStrings.resend,
                                        textColor: AppColors.green500,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink();
                        }),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
