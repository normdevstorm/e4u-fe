import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e4u_application/presentation/common/debounce_button.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/gen/assets.gen.dart';
import 'package:e4u_application/presentation/auth/widgets/auth_pill_widgets.dart';
import 'package:e4u_application/presentation/auth/controllers/login_controller.dart';

class LoginDesktopScreen extends StatelessWidget {
  const LoginDesktopScreen({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.baseWhite,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Row(
          children: [
            // Left side - Logo/Image section
            Expanded(
              flex: 5,
              child: Container(
                color: ColorManager.purpleLight,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(80.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 400.w,
                          height: 400.h,
                          child: Assets.images.doctorLoginImage.image(
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Text(
                          'Welcome Back!',
                          textAlign: TextAlign.center,
                          style: StyleManager.headingLargeSemiBold.copyWith(
                            color: ColorManager.grey950,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Sign in to continue your learning journey',
                          textAlign: TextAlign.center,
                          style: StyleManager.bodyMedium.copyWith(
                            color: ColorManager.grey500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Right side - Login form section
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Container(
                  constraints: BoxConstraints(minHeight: 600.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 80.w,
                    vertical: 60.h,
                  ),
                  child: Form(
                    key: controller.emailFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Log in with email',
                          style: StyleManager.headingLargeSemiBold.copyWith(
                            color: ColorManager.grey950,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Enter your credentials to access your account',
                          style: StyleManager.bodyMedium.copyWith(
                            color: ColorManager.grey500,
                          ),
                        ),
                        SizedBox(height: 48.h),
                        const AuthRequiredLabel(label: 'Email'),
                        SizedBox(height: 4.h),
                        AuthPillTextField(
                          controller: controller.emailController,
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: controller.validateEmail,
                        ),
                        SizedBox(height: 20.h),
                        const AuthRequiredLabel(label: 'Password'),
                        SizedBox(height: 4.h),
                        ValueListenableBuilder(
                          valueListenable: controller.isHiddenPasswordNotifier,
                          builder: (context, isHiddenPassword, child) =>
                              AuthPillTextField(
                            controller: controller.passwordController,
                            hintText: 'Password',
                            obscureText: isHiddenPassword,
                            textInputAction: TextInputAction.done,
                            suffixIcon: IconButton(
                              icon: Icon(
                                isHiddenPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 18.sp,
                                color: ColorManager.grey950,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        DebouncedButton(
                          debounceTimeMs: 1000,
                          customBorder: const StadiumBorder(),
                          onPressed: () => controller.handleLogin(context),
                          button: const AuthPrimaryPillButton(
                            text: 'Log in',
                          ),
                        ),
                        SizedBox(height: 20.h),
                        AuthTermsText(
                          onTapTerms: () =>
                              controller.handleTermsClick(context),
                          onTapPrivacy: () =>
                              controller.handlePrivacyClick(context),
                        ),
                        SizedBox(height: 24.h),
                        const AuthOrDivider(),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(
                              child: AuthSocialButton(
                                label: 'Facebook',
                                icon: Assets.icons.logosFacebook,
                                onTap: () =>
                                    controller.handleFacebookLogin(context),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: AuthSocialButton(
                                label: 'Apple',
                                icon: Assets.icons.deviconApple,
                                onTap: () =>
                                    controller.handleAppleLogin(context),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 32.h),
                        AuthBottomLink(
                          prefix: 'Don\'t have an account? ',
                          linkText: 'Sign up',
                          onTap: () => controller.navigateToRegister(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
