import 'package:flutter/material.dart';
import '../route_define.dart';
import '../../../presentation/splash/ui/splash_screen.dart';
import '../../../presentation/auth/ui/login_screen.dart';
import '../../../presentation/auth/ui/register_screen.dart';
import '../../../presentation/home/ui/home_screen.dart';

/// Route generator for mobile Navigator-based routing
/// This class generates routes based on route names defined in RouteDefine
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Splash Screen
      case '/':
      case RouteDefine.auth:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      // Authentication Routes
      case RouteDefine.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case RouteDefine.register:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        );

      // Home Route
      case RouteDefine.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      // Default - Route not found
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Route ${settings.name} not found'),
            ),
          ),
        );
    }
  }

  /// Get initial route based on authentication status
  static String getInitialRoute(bool isAuthenticated) {
    if (isAuthenticated) {
      return RouteDefine.homeScreen;
    }
    return RouteDefine.login;
  }
}
