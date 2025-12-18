import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:e4u_application/app/config/api_exception.dart';
import 'package:e4u_application/app/di/injection.dart';
import 'package:e4u_application/app/managers/local_storage.dart';
import 'package:e4u_application/app/managers/session_manager.dart';
import 'package:e4u_application/data/auth/models/request/login_request_model.dart';
import 'package:e4u_application/domain/auth/entities/login_entity.dart';
import 'package:e4u_application/domain/auth/usecases/authentication_usecase.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:logger/logger.dart';

import '../../../app/app.dart';
import '../../../data/auth/models/request/register_request_model.dart';
import '../../../domain/auth/entities/register_entity.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationUsecase authenticationUsecase;

  AuthenticationBloc({
    required this.authenticationUsecase,
  }) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {});
    on<LoginSubmitEvent>((event, emit) => onLoginSubmit(event, emit));
    on<CheckLoginStatusEvent>(
        (event, emit) => onCheckLoginStatusEvent(event, emit));
    on<LogOutEvent>((event, emit) => onLogOutEvent(event, emit));
    on<RegisterSubmitEvent>((event, emit) => onRegisterEvent(event, emit));
    // Verify code events removed - add back when verify_code feature is implemented
    // on<VerifyCodeSubmitEvent>(
    //     (event, emit) => onVerifyCodeSubmitEvent(event, emit));
    // on<GetVerifyCodeEvent>((event, emit) => onGetVerifyCodeEvent(event, emit));
  }

  onLoginSubmit(
      LoginSubmitEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      LoginEntity? loginEntity = await loginMainService(event);
      // Firebase chat login removed - add back when chat feature is implemented
      // await loginFirebaseChat(event);
      if (loginEntity != null) {
        emit(LoginSuccess(loginEntity));
      } else {
        emit(const LoginError("Login failed"));
      }
    } on ApiException catch (e) {
      getIt<Logger>().e(e);
      emit(LoginError(ApiException.getErrorMessage(e)));
    } catch (e) {
      getIt<Logger>().e(e);
      emit(LoginError('Login failed: ${e.toString()}'));
    }
  }

  // Firebase chat login removed - add back when chat feature is implemented
  // Future<void> loginFirebaseChat(LoginSubmitEvent event) async {
  //   // Implementation removed
  // }

  Future<LoginEntity?> loginMainService(LoginSubmitEvent event) async {
    final String fcmToken = SharedPreferenceManager.readFcmToken() ??
        "cAdhk0s-QIacSG-bsRbLsC:APA91bEOrduaBH8NRaQCvchuX1MYNMtpFyTQe1yu5aLadWblHN7v8Ik6pCBbn26VoMP5kHfvGGoJpGTIXPZumNTXflRwBcnO6e0Qo2PIlyESq_s1oAnYcvt7BXEn33JxJUm-tkq8130Q";
    LoginRequest loginRequest = LoginRequest(
        email: event.email, password: event.password, fcmToken: fcmToken);
    final loginEntity = await authenticationUsecase.login(loginRequest);
    return loginEntity;
  }

  onCheckLoginStatusEvent(
      CheckLoginStatusEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      // check session in local storage
      final loginEntity = SessionManager().getSession();
      final bool isLogin = SessionManager().getLoginStatus() ?? false;
      // Firebase chat session check removed - add back when chat feature is implemented
      // bool isSignIn = await appChatUseCases.auth.isSignedIn();
      // User? user = await appChatUseCases.auth.getCurrentUser();

      if (loginEntity == null || isLogin == false) {
        if (loginEntity != null) {
          SessionManager().clearSession();
        }
        emit(AuthenticationInitial());
      } else {
        bool hasExpired = JwtDecoder.isExpired(loginEntity.accessToken ?? "");
        if (hasExpired) {
          await authenticationUsecase
              .refreshToken(loginEntity.refreshToken ?? "");
        }
        emit(LoginSuccess(loginEntity));
      }
    } on ApiException catch (e) {
      SessionManager().clearSession();
      emit(CheckLoginStatusErrorState(ApiException.getErrorMessage(e)));
    } catch (e) {
      SessionManager().clearSession();
      emit(CheckLoginStatusErrorState(e.toString()));
    }
  }

  onLogOutEvent(LogOutEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      await authenticationUsecase.logout();
      // Firebase chat logout removed - add back when chat feature is implemented
      // await appChatUseCases.auth.signOut();
      emit(AuthenticationInitial());
    } on ApiException catch (e) {
      getIt<Logger>().e(e);
      emit(LoginError(ApiException.getErrorMessage(e)));
    } catch (e) {
      getIt<Logger>().e(e);
      emit(LoginError(e.toString()));
    }
  }

  onRegisterEvent(
      RegisterSubmitEvent event, Emitter<AuthenticationState> emit) async {
    try {
      RegisterEntity? registerEntity = await registerToMainService(emit, event);
      // Firebase chat registration removed - add back when chat feature is implemented
      // await registerToFirebase(
      //     email: event.email,
      //     password: event.password,
      //     mainServiceId: registerEntity?.user.id,
      //     username: event.username);
      emit(RegisterSuccess(registerEntity));
    } on ApiException catch (e) {
      emit(LoginError(ApiException.getErrorMessage(e)));
    } catch (e) {
      emit(LoginError('Error: ${e.toString()}'));
    }
  }

  // Firebase chat registration removed - add back when chat feature is implemented
  // Future<void> registerToFirebase(...) async {
  //   // Implementation removed
  // }

  Future<RegisterEntity?> registerToMainService(
      Emitter<AuthenticationState> emit, RegisterSubmitEvent event) async {
    emit(AuthenticationLoading());
    final registerEntity = await authenticationUsecase.register(RegisterRequest(
        email: event.email,
        password: event.password,
        username: event.username,
        role: event.role));
    return registerEntity;
  }

  // Verify code methods removed - add back when verify_code feature is implemented
  // onVerifyCodeSubmitEvent(
  //     VerifyCodeSubmitEvent event, Emitter<AuthenticationState> emit) async {
  //   // Implementation removed
  // }

  // onGetVerifyCodeEvent(
  //     GetVerifyCodeEvent event, Emitter<AuthenticationState> emit) async {
  //   // Implementation removed
  // }
}
