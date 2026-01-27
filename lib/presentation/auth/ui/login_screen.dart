import 'package:flutter/material.dart';
import 'package:e4u_application/presentation/common/base_wrapper.dart';
import 'package:e4u_application/presentation/auth/ui/login_mobile_screen.dart';
import 'package:e4u_application/presentation/auth/ui/login_desktop_screen.dart';
import 'package:e4u_application/presentation/auth/controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LoginController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWrapper(
      mobile: LoginMobileScreen(controller: _controller),
      desktop: LoginDesktopScreen(controller: _controller),
    );
  }
}
