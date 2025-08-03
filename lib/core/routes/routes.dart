import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:key_bridge/features/register_admin/data/models/register_page_args.dart'
    show RegisterPageArgs;
import 'package:key_bridge/imports.dart';

class Routes {
  static BuildContext? buildContext;

  Routes._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static const String mainScreen = '/';
  static const String splashScreen = '/splash';
  static const String loginScreen = '/login';
  static const String registerAdminScreen = '/registerAdminScreen';
  static const String forgetPasswordScreen = '/forget_password';
  static const String profileScreen = '/profile';
  static const String codeScreen = '/code';
  static const String adminHomeScreen = '/admingHome';
  static const String registerUserScreen = '/registerUserScreen';
  static const String scannerScreen = '/scannerScreen';
  static const String otpScreen = '/otpScreen';

  static final GoRouter goRouter = GoRouter(
    observers: [],
    initialLocation: loginScreen,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: false,
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: mainScreen,
        name: mainScreen,
        pageBuilder: (context, state) =>
            _fadeTransitionScreenWrapper(context, state, TestFeaturePage()),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: splashScreen,
        name: splashScreen,
        pageBuilder: (context, state) =>
            _fadeTransitionScreenWrapper(context, state, SplashScreen()),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: loginScreen,
        name: loginScreen,
        pageBuilder: (context, state) {
          final LoginPageArgs? args = state.extra is LoginPageArgs
              ? state.extra as LoginPageArgs
              : null;
          return _fadeTransitionScreenWrapper(
              context,
              state,
              BlocProvider(
                  create: (context) => LoginBloc(
                        loginUsecase: getIt<LoginUsecase>(),
                      ),
                  child: LoginPage(
                    args: args,
                  )));
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: otpScreen,
        name: otpScreen,
        pageBuilder: (context, state) {
          final OtpPageArgs? args =
              state.extra is OtpPageArgs ? state.extra as OtpPageArgs : null;

          return _fadeTransitionScreenWrapper(
              context,
              state,
              BlocProvider(
                  create: (context) => RegisterAdminBloc(
                        registrationUsecase: getIt<RegisterAdminUsecase>(),
                        sendEmailUsecase: getIt<SendEmailUsecase>(),
                      ),
                  child: OtpPage(
                    requestModel: args!.registerAdminRequestModel,
                  )));
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: registerAdminScreen,
        name: registerAdminScreen,
        pageBuilder: (context, state) {
          final RegisterPageArgs? args = state.extra is RegisterPageArgs
              ? state.extra as RegisterPageArgs
              : null;
          return _fadeTransitionScreenWrapper(
              context,
              state,
              RegisterAdminPage(
                args: args,
              ));
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: profileScreen,
        name: profileScreen,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
            context,
            state,
            BlocProvider(
                create: (context) => ProfileBloc(
                      profileUsecase: getIt<ProfileUsecase>(),
                      updateProfileUsecase: getIt<UpdateProfileUsecase>(),
                    ),
                child: ProfilePage())),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: registerUserScreen,
        name: registerUserScreen,
        pageBuilder: (context, state) {
          final RegisterUserPageArgs? args = state.extra is RegisterUserPageArgs
              ? state.extra as RegisterUserPageArgs
              : null;

          return _fadeTransitionScreenWrapper(
              context,
              state,
              BlocProvider(
                  create: (context) => RegisterUserBloc(
                        registerUserUsecase: getIt<RegisterUserUsecase>(),
                        updateUserUsecase: getIt<UpdateUserUsecase>(),
                      ),
                  child: RegisterUserPage(
                    args: args,
                  )));
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: codeScreen,
        name: codeScreen,
        pageBuilder: (context, state) {
          return _fadeTransitionScreenWrapper(context, state, CodePage());
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: scannerScreen,
        name: scannerScreen,
        pageBuilder: (context, state) {
          return _fadeTransitionScreenWrapper(context, state, ScannerPage());
        },
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: adminHomeScreen,
        name: adminHomeScreen,
        pageBuilder: (context, state) {
          return _fadeTransitionScreenWrapper(
              context,
              state,
              BlocProvider(
                  create: (context) => AdminHomeBloc(
                        adminHomeUseCase: getIt<AdminHomeUseCase>(),
                        enableDisableUserUseCase:
                            getIt<EnableDisableUserUseCase>(),
                        resetUserUseCase: getIt<ResetUserUseCase>(),
                        deleteUserUseCase: getIt<DeleteUserUseCase>(),
                        enableDisableAllUsersUseCase:
                            getIt<EnableDisableAllUsersUseCase>(),
                      ),
                  child: AdminHomePage()));
        },
      ),
    ],
  );

  static bool currentScreen(String route, BuildContext context) {
    final String state =
        GoRouter.of(context).routeInformationProvider.value.uri.path;
    return state.contains(route);
  }

  static Future<void> navigateToScreen(
    String screenName,
    NavigationType navigateType,
    BuildContext context, {
    Map<String, String>? queryParameters,
    Object? extra,
    Function(String)? onPop,
  }) async {
    switch (navigateType) {
      case NavigationType.pushNamed:
        await GoRouter.of(context)
            .pushNamed(screenName,
                queryParameters: queryParameters ?? {}, extra: extra)
            .then(
          (value) {
            if (onPop != null && value != null && value is String) {
              onPop(value);
            }
          },
        );
        break;

      case NavigationType.goNamed:
        GoRouter.of(context).goNamed(screenName,
            queryParameters: queryParameters ?? {}, extra: extra);
        break;

      case NavigationType.pushReplacementNamed:
        GoRouter.of(context).pushReplacementNamed(screenName,
            queryParameters: queryParameters ?? {}, extra: extra);
        break;

      default:
        GoRouter.of(context)
            .goNamed(screenName, queryParameters: queryParameters ?? {});
        break;
    }
  }

  static void clearStack() {
    while (Navigator.canPop(rootNavigatorKey.currentContext!)) {
      Navigator.of(rootNavigatorKey.currentContext!).pop();
    }
  }

  static void navigateToFirstScreen(context) {
    while (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  static CustomTransitionPage<dynamic> _fadeTransitionScreenWrapper(
      BuildContext context, dynamic state, Widget screen) {
    return CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.linear).animate(animation),
          child: child,
        );
      },
      key: state.pageKey,
      child: screen,
    );
  }
}
