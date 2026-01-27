import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:e4u_application/presentation/common/base_wrapper.dart';
import 'package:e4u_application/presentation/common/desktop/skeleton_desktop_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:e4u_application/main.dart';
import 'package:e4u_application/presentation/splash/ui/splash_screen.dart';
import '../../presentation/nav_bar/bloc/navigation_bar_bloc.dart';
import 'custom_navigator_observer.dart';

// Import route definitions
import '../../presentation/auth/auth_route.dart' show loginRoute, registerRoute;
import '../../presentation/home/home_route.dart' show homeRoute;
import '../../presentation/learning/learning_route.dart' show learningRoute;
import '../../presentation/stats/stats_route.dart' show statsRoute;
import '../../presentation/profile/profile_route.dart' show profileRoute;

///TODO: group naviagtor keys into one separate file
final GlobalKey<NavigatorState> rootNavigatorHome = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> rootNavigatorLearning =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> rootNavigatorStats =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> rootNavigatorProfile =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> rootNavigatorAuthentication =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> globalRootNavigatorKey =
    GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> rootNavigatorArticles =
//     GlobalKey<NavigatorState>();

class AppRouting {
  static final ValueNotifier<bool> navBarVisibleNotifier =
      ValueNotifier<bool>(true);
  static final CustomNavigatorObserver customNavigatorObserver =
      CustomNavigatorObserver();
  static final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();
  static final RouteObserver<ModalRoute<void>> appointmentRouteObserver =
      RouteObserver<ModalRoute<void>>();
  static GoRouter get shellRouteConfig => _shellRoute;
  static final GoRouter _shellRoute = GoRouter(
      observers: [
        ChuckerFlutter.navigatorObserver,
        routeObserver,
        customNavigatorObserver
      ],
      navigatorKey: globalRootNavigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          parentNavigatorKey: globalRootNavigatorKey,
          path: '/',
          builder: (context, state) => const SplashScreen(),
          redirect: (context, state) {
            //TODO: base the logic below for further notification handling
            // if (state.uri.queryParameters["source"] == "notification") {
            //   final appointmentId =
            //       int.parse(state.uri.queryParameters['appointmentId'] ?? '0');
            //   return "/appointment/details/$appointmentId";
            // }
            return null;
          },
        ),
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: globalRootNavigatorKey,
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: [loginRoute, registerRoute],
              navigatorKey: rootNavigatorAuthentication,
            )
          ],
          builder: (context, state, navigationShell) => navigationShell,
        ),
        StatefulShellRoute.indexedStack(
            restorationScopeId: 'root',
            parentNavigatorKey: globalRootNavigatorKey,
            builder: (context, state, navigationShell) => BlocProvider(
                create: (context) => NavigationBarBloc(),
                child: BaseWrapper(
                    mobile: SkeletonMobilePage(
                        title: "Skeleton mobile", child: navigationShell),
                    desktop: SkeletonDesktopPage(
                        title: "Skeleton desktop", child: navigationShell))),
            branches: <StatefulShellBranch>[
              StatefulShellBranch(
                  navigatorKey: rootNavigatorHome,
                  routes: <RouteBase>[homeRoute]),
              StatefulShellBranch(
                  navigatorKey: rootNavigatorLearning,
                  routes: <RouteBase>[learningRoute]),
              StatefulShellBranch(
                  navigatorKey: rootNavigatorStats,
                  routes: <RouteBase>[statsRoute]),
              StatefulShellBranch(
                  navigatorKey: rootNavigatorProfile,
                  routes: <RouteBase>[profileRoute]),
            ])
      ]);
}
