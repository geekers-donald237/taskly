import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/data/repositories/task_repository_impl.dart';
import 'package:taskly/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:taskly/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:taskly/presentation/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:taskly/presentation/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:taskly/presentation/pages/home/main_screen.dart';

import 'core/services/app_language/app_language.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/sources/local/data_provider.dart';
import 'data/sources/local/local_storage_impl.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'domain/usecases/register_with_google_usecase.dart';
import 'domain/usecases/sign_in_with_google_usecase.dart';
import 'localization/app_localization.dart';

class Taskly extends StatelessWidget {
  final AppLanguage appLanguage;
  final SharedPreferences preferences;

  const Taskly({required this.appLanguage, required this.preferences});

  @override
  Widget build(BuildContext context) {
    final authRepository =
        AuthRepositoryImpl(FirebaseAuth.instance, LocalStorageImpl());
    final loginUseCase = LoginUseCase(authRepository);
    final registerUseCase = RegisterUseCase(authRepository);
    final logoutUseCase = LogoutUseCase(authRepository);
    final signInWithGoogleUseCase = SignInWithGoogleUseCase(authRepository);
    final registerWithGoogleUseCase = RegisterWithGoogleUseCase(authRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppBloc(appLanguage.appLocale),
        ),
        BlocProvider(
          create: (_) => TasksBloc(
            TaskRepositoryImpl(
                taskDataProvider: TaskDataLocalStorageProvider(preferences)),
          ),
        ),
        BlocProvider(
          create: (_) => AuthBloc(
              loginUseCase,
              registerUseCase,
              logoutUseCase,
              signInWithGoogleUseCase,
              registerWithGoogleUseCase,
              LocalStorageImpl()),
        ),
        BlocProvider(
          create: (_) => ConnectivityBloc()..add(OnConnectivityEvent()),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return FlutterSizer(
            builder: (context, orientation, screenType) {
              return MaterialApp(
                title: 'TaskFly',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: 'Satoshi',
                  primaryColor: const Color(0xFF7B1FA2),
                  primaryColorDark: const Color(0xFF9C27B0),
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color(0xFF9C27B0),
                    onPrimary: const Color(0xFFFFFFFF),
                    onSurface: const Color(0xFFB0BEC5),
                    onSecondary: const Color(0xFF1E1E1E),
                    onBackground: const Color(0xFFFFFFFF),
                    secondary: const Color(0xFFFF4081),
                    background: const Color(0xFFFFFFFF),
                    surface: const Color(0xFF2C2C2C),
                    brightness: Brightness.light,
                  ),
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  fontFamily: 'Satoshi',
                  primaryColor: const Color(0xFF7B1FA2),
                  primaryColorDark: const Color(0xFF9C27B0),
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color(0xFF9C27B0),
                    onPrimary: const Color(0xFFFFFFFF),
                    surface: const Color(0xFF2C2C2C),
                    onSecondary: const Color(0xFF1E1E1E),
                    onSurface: const Color(0xFFB0BEC5),
                    secondary: const Color(0xFFFF4081),
                    background: const Color(0xFF1E1E1E),
                    brightness: Brightness.dark,
                  ),
                  scaffoldBackgroundColor: Colors.black,
                  useMaterial3: true,
                ),
                locale: state.locale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                themeMode: ThemeMode.dark,
                home: const MainScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
