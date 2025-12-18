// part of '../app.dart';
import 'dart:io';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:e4u_application/app/config/firebase_api.dart';
import 'package:e4u_application/app/config/refresh_token_interceptor.dart';
import 'package:e4u_application/app/config/request_interceptor.dart';
import 'package:e4u_application/app/managers/cache_manager.dart';
import 'package:e4u_application/app/utils/local_notification/notification_service.dart';
import 'package:e4u_application/data/auth/api/authentication_api.dart';
import 'package:e4u_application/data/auth/repositories/authentication_repository_impl.dart';
import 'package:e4u_application/domain/auth/repositories/authentication_repository.dart';
import 'package:e4u_application/domain/auth/usecases/authentication_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../firebase/firebase_options_chat.dart';
import '../app.dart';
import '../managers/local_storage.dart';
// import 'injection.config.dart'; // Generated file - will be created by build_runner
import 'package:timezone/data/latest.dart' as tz;

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies(FlavorManager flavor) async {
  // getIt.init(); // Uncomment after running: flutter pub run build_runner build
  await setUpNetworkComponent(flavor);
  await setUpAppUtilitis(flavor);
  setUpAppComponent(flavor);
}

Future<void> setUpAppUtilitis(FlavorManager flavor) async {
  //SharedPreference
  await SharedPreferenceManager.init();

  //Logger
  getIt.registerSingleton<Logger>(Logger(
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
  ));

  // Initialize the cloud message Firebase project
  await FirebaseMessageService().initNotificaiton();
  // Initialize the chat Firebase project
  await Firebase.initializeApp(
    options: DefaultChatFirebaseOptions.currentPlatform,
    name: 'chatApp',
  );

  // Initialize Notification Service
  tz.initializeTimeZones();
  await NotificationService.initializeNotification();
}

Future<void> setUpNetworkComponent(FlavorManager flavor) async {
  final cacheOption = await CacheManager.dioCacheoptions();

  Dio dio = Dio(BaseOptions(
    baseUrl: ConfigManager.getInstance(flavorName: flavor.name).apiBaseUrl,
    contentType: Headers.jsonContentType,
    headers: {
      HttpHeaders.accessControlAllowOriginHeader: "*",
      HttpHeaders.accessControlAllowMethodsHeader:
          "GET, POST, PUT, DELETE, OPTIONS",
    },
  ));
  dio.interceptors.addAll([
    PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        request: true),
    ChuckerDioInterceptor(),
    RefreshTokenInterceptor(),
    RequestInterceptor(),
    DioCacheInterceptor(options: cacheOption),
  ]);
  getIt.registerSingleton<Dio>(dio);

  // Register only auth API
  getIt.registerLazySingleton(() => AuthenticationApi(dio));
}

setUpAppComponent(FlavorManager flavor) {
  //Inject repositories - only auth
  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getIt(), getIt()));

  //Inject Usecases - only auth
  getIt.registerLazySingleton(() => AuthenticationUsecase(getIt()));
}
