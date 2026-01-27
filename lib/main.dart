import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:e4u_application/app/app.dart';
import 'package:e4u_application/app/route/app_routing.dart';
import 'package:e4u_application/app/route/route_define.dart';
import 'package:e4u_application/app/utils/regex/regex_manager.dart';
import 'package:e4u_application/domain/auth/usecases/authentication_usecase.dart';
import 'package:e4u_application/presentation/auth/bloc/authentication_bloc.dart';
import 'package:e4u_application/presentation/common/chucker_log_button.dart';
import 'package:e4u_application/presentation/common/app_icon.dart';
import 'app/di/injection.dart';
import 'app/managers/toast_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String flavor =
      String.fromEnvironment('FLAVOR', defaultValue: 'staging');

  await configureDependencies(
      FlavorManager.values.firstWhere((element) => element.name == flavor));

  print('Flavor: $flavor');

  usePathUrlStrategy();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    builder: (context, child) => EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      path: 'assets/resources/langs/langs.csv',
      assetLoader: CsvAssetLoader(),
      startLocale: const Locale('en', 'US'),
      useFallbackTranslations: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              authenticationUsecase: getIt<AuthenticationUsecase>(),
            ),
          ),
        ],
        child: const BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: _authenticationListener,
          child: MyApp(),
        ),
      ),
    ),
  ));
}

void _authenticationListener(BuildContext context, AuthenticationState state) {
  BuildContext currentContext =
      globalRootNavigatorKey.currentContext ?? context;
  if (state is AuthenticationLoading) {
    showDialog(
        barrierColor: Colors.transparent,
        context: currentContext,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    return;
  } else {
    currentContext.canPop() ? currentContext.pop() : null;
  }
  if (state is AuthenticationInitial) {
    //TODO: REVERT TO LOGIN ROUTE
    GoRouter.of(currentContext).goNamed(RouteDefine.homeScreen);
    return;
  }

  if (state is LoginSuccess) {
    GoRouter.of(currentContext).goNamed(RouteDefine.homeScreen);
    return;
  }

  if (state is RegisterSuccess) {
    ToastManager.showToast(
        context: currentContext, message: 'Register successfully');
    GoRouter.of(currentContext).goNamed(RouteDefine.login);
    return;
  }

  if (state is AuthenticationError) {
    String errorMessage = state.message;
    //todo: localize this message
    ToastManager.showToast(context: currentContext, message: errorMessage);
    if (state.runtimeType == CheckLoginStatusErrorState) {
      GoRouter.of(currentContext).goNamed(RouteDefine.login);
    }
    return;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Size designSize =
        _isMobilePlatform ? const Size(375, 812) : const Size(1440, 900);

    MaterialApp mainApp = MaterialApp.router(
      builder: FToastBuilder(),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      darkTheme: ThemeManager.darkTheme,
      theme: ThemeManager.lightTheme.copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      })),
      routerConfig: AppRouting.shellRouteConfig,
      debugShowCheckedModeBanner: false,
    );

    return ScreenUtilInit(
      designSize: designSize,
      useInheritedMediaQuery: true,
      builder: (context, child) => Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Stack(children: [
          mainApp,
          Positioned(bottom: 5.sp, right: 5.sp, child: const ChuckerLogButton())
        ]),
      ),
      child: mainApp,
    );
  }
}

bool get _isMobilePlatform {
  if (kIsWeb) {
    // Treat web as desktop-like by default for layout purposes.
    return false;
  }

  return defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;
}

class SkeletonMobilePage extends StatefulWidget {
  const SkeletonMobilePage(
      {super.key, required this.title, required this.child});

  final String title;
  final StatefulNavigationShell child;

  @override
  State<SkeletonMobilePage> createState() => _SkeletonMobilePageState();
}

class _SkeletonMobilePageState extends State<SkeletonMobilePage> {
  late ScrollController _scrollController;
  late ValueNotifier<bool> _navBarVisibleNotifier;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _navBarVisibleNotifier = AppRouting.navBarVisibleNotifier;
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_navBarVisibleNotifier.value) {
          _navBarVisibleNotifier.value = false;
        }
      } else if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward ||
          _scrollController.position.maxScrollExtent > 0) {
        if (!_navBarVisibleNotifier.value) {
          _navBarVisibleNotifier.value = true;
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomBar(
      showIcon: false,
      barColor: Colors.transparent,
      width: MediaQuery.of(context).size.width * 0.7,
      hideOnScroll: true,
      body: (context, controller) {
        return Scaffold(
            body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.metrics.axis == Axis.vertical) {
                      if (scrollNotification.scrollDelta! > 0 &&
                          _navBarVisibleNotifier.value) {
                        _navBarVisibleNotifier.value = false;
                      } else if (scrollNotification.scrollDelta! < 0 &&
                          !_navBarVisibleNotifier.value) {
                        _navBarVisibleNotifier.value = true;
                      }
                    }
                    return true;
                  },
                  child: widget.child,
                ),
              ),
            ],
          ),
        ));
      },
      child: _hideBottomNavBar(context)
          ? const SizedBox()
          : ValueListenableBuilder(
              valueListenable: _navBarVisibleNotifier,
              builder: (context, navbarVisible, child) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: navbarVisible ? kBottomNavigationBarHeight * 1.2 : 0.0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: BottomNavigationBar(
                      enableFeedback: false,
                      currentIndex: widget.child.currentIndex,
                      selectedItemColor: ColorManager.primaryColorLight,
                      unselectedItemColor: ColorManager.iconColorLight,
                      onTap: (value) => widget.child.goBranch(value),
                      type: BottomNavigationBarType.fixed,
                      items: const [
                        BottomNavigationBarItem(
                          icon: AppIcon(
                            assetPath: IconManager.home,
                            size: 24.0,
                            color: ColorManager.iconColorLight,
                          ),
                          activeIcon: AppIcon(
                            assetPath: IconManager.home,
                            size: 24.0,
                            color: ColorManager.primaryColorLight,
                          ),
                          label: "Home",
                        ),
                        BottomNavigationBarItem(
                          icon: AppIcon(
                            assetPath: IconManager.bookOpen,
                            size: 24.0,
                            color: ColorManager.iconColorLight,
                          ),
                          activeIcon: AppIcon(
                            assetPath: IconManager.bookOpen,
                            size: 24.0,
                            color: ColorManager.primaryColorLight,
                          ),
                          label: "Learn",
                        ),
                        BottomNavigationBarItem(
                          icon: AppIcon(
                            assetPath: IconManager.analytics,
                            size: 24.0,
                            color: ColorManager.iconColorLight,
                          ),
                          activeIcon: AppIcon(
                            assetPath: IconManager.analytics,
                            size: 24.0,
                            color: ColorManager.primaryColorLight,
                          ),
                          label: "Stats",
                        ),
                        BottomNavigationBarItem(
                          icon: AppIcon(
                            assetPath: IconManager.setting,
                            size: 24.0,
                            color: ColorManager.iconColorLight,
                          ),
                          activeIcon: AppIcon(
                            assetPath: IconManager.setting,
                            size: 24.0,
                            color: ColorManager.primaryColorLight,
                          ),
                          label: "Settings",
                        ),
                      ]),
                ),
              ),
            ),
    );
  }

  bool _hideBottomNavBar(BuildContext context) {
    final bool hideNavBar = GoRouter.of(context)
            .state
            .matchedLocation
            .startsWith(RegexManager.hideBottomNavBarPaths) ??
        false;
    if (!hideNavBar) {
      _navBarVisibleNotifier.value = true;
    }
    return hideNavBar;
  }
}
