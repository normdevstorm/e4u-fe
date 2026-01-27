import 'package:flutter/material.dart';
import 'package:e4u_application/presentation/common/debounce_button.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/gen/assets.gen.dart';
import 'package:e4u_application/presentation/auth/widgets/auth_pill_widgets.dart';
import 'package:e4u_application/presentation/auth/controllers/login_controller.dart';

class LoginMobileScreen extends StatelessWidget {
  const LoginMobileScreen({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.grey50,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: controller.emailFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 32),
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: Assets.images.doctorLoginImage.image(
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Log in with email',
                              textAlign: TextAlign.center,
                              style: StyleManager.headingLargeSemiBold.copyWith(
                                color: ColorManager.grey950,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AuthRequiredLabel(label: 'Email'),
                                const SizedBox(height: 4),
                                AuthPillTextField(
                                  controller: controller.emailController,
                                  hintText: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                  validator: controller.validateEmail,
                                ),
                                const SizedBox(height: 12),
                                const AuthRequiredLabel(label: 'Password'),
                                const SizedBox(height: 4),
                                ValueListenableBuilder(
                                  valueListenable:
                                      controller.isHiddenPasswordNotifier,
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
                                        size: 18,
                                        color: ColorManager.grey950,
                                      ),
                                      onPressed:
                                          controller.togglePasswordVisibility,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                DebouncedButton(
                                  debounceTimeMs: 1000,
                                  customBorder: const StadiumBorder(),
                                  onPressed: () =>
                                      controller.handleLogin(context),
                                  button: const AuthPrimaryPillButton(
                                    text: 'Log in',
                                  ),
                                ),
                                const SizedBox(height: 12),
                                AuthTermsText(
                                  onTapTerms: () =>
                                      controller.handleTermsClick(context),
                                  onTapPrivacy: () =>
                                      controller.handlePrivacyClick(context),
                                ),
                                const SizedBox(height: 12),
                                const AuthOrDivider(),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AuthSocialButton(
                                        label: 'Facebook',
                                        icon: Assets.icons.logosFacebook,
                                        onTap: () => controller
                                            .handleFacebookLogin(context),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: AuthSocialButton(
                                        label: 'Apple',
                                        icon: Assets.icons.deviconApple,
                                        onTap: () => controller
                                            .handleAppleLogin(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: AuthBottomLink(
                            prefix: 'Don\'t have an account? ',
                            linkText: 'Sign up',
                            onTap: () => controller.navigateToRegister(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
