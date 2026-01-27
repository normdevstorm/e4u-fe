import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:e4u_application/app/route/route_define.dart';
import 'package:e4u_application/presentation/auth/bloc/authentication_bloc.dart';

/// Shared login logic controller that can be used by both mobile and desktop screens.
/// This keeps all business logic (controllers, validation, state, callbacks) separate from UI.
class LoginController {
  final ValueNotifier<bool> isHiddenPasswordNotifier =
      ValueNotifier<bool>(true);
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final TextEditingController emailController =
      TextEditingController(text: 'nguyenducduypc160903@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: '12332145');

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isHiddenPasswordNotifier.value = !isHiddenPasswordNotifier.value;
  }

  /// Validate email format
  String? validateEmail(String? value) {
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value ?? "")) {
      return 'Invalid email!';
    }
    return null;
  }

  /// Handle login button click - validates form and dispatches LoginSubmitEvent
  void handleLogin(BuildContext context) {
    if (emailFormKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(LoginSubmitEvent(
            emailController.text,
            passwordController.text,
          ));
    }
  }

  /// Handle Facebook login button click
  void handleFacebookLogin(BuildContext context) {
    // TODO: implement facebook login
  }

  /// Handle Apple login button click
  void handleAppleLogin(BuildContext context) {
    // TODO: implement apple login
  }

  /// Navigate to register screen
  void navigateToRegister(BuildContext context) {
    context.pushNamed(RouteDefine.register);
  }

  /// Handle Terms & Service link click
  void handleTermsClick(BuildContext context) {
    // TODO: open Terms & Service
  }

  /// Handle Privacy Policy link click
  void handlePrivacyClick(BuildContext context) {
    // TODO: open Privacy Policy
  }

  /// Dispose all controllers and notifiers
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    isHiddenPasswordNotifier.dispose();
  }
}
