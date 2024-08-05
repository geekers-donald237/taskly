import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskly/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:taskly/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:taskly/presentation/blocs/connectivity_bloc/connectivity_bloc.dart';

import 'package:taskly/presentation/pages/auth/login_page.dart';
import 'package:taskly/presentation/pages/home/home_screen.dart';
import 'core/services/app_language/app_language.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/sources/local/local_storage_impl.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/sign_in_with_google_usecase.dart';
import 'domain/usecases/register_with_google_usecase.dart';
import 'localization/app_localization.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();

  final localStorageService = LocalStorageImpl();
  final String? userToken = localStorageService.getToken();

  runApp(MyApp(appLanguage: appLanguage, userToken: userToken));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  final String? userToken;

  const MyApp({required this.appLanguage, this.userToken});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepositoryImpl(FirebaseAuth.instance, LocalStorageImpl());
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
          create: (_) => AuthBloc(loginUseCase, registerUseCase, logoutUseCase, signInWithGoogleUseCase, registerWithGoogleUseCase, LocalStorageImpl()),
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
                  primaryColor: const Color.fromRGBO(136, 117, 255, 1.0),
                  primaryColorDark: const Color(0xFF3700B3),
                  colorScheme: ColorScheme.fromSeed(
                    onPrimary: const Color(0xFFFFFFFF),
                    onSurface: const Color(0xFF7A7A7A),
                    onSecondary: Colors.white70,
                    seedColor: Colors.white10,
                    brightness: Brightness.light,
                  ),
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  fontFamily: 'Satoshi',
                  primaryColor: const Color.fromRGBO(136, 117, 255, 1.0),
                  primaryColorDark: const Color(0xFF3700B3),
                  colorScheme: ColorScheme.fromSeed(
                    onPrimary: const Color(0xFFFFFFFF),
                    seedColor: Colors.white10,
                    surface: Colors.white,
                    onSecondary: Colors.white70,
                    onSurface: const Color(0xFF7A7A7A),
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
                home: userToken != null ? const MainScreen() : const LoginPage(),
              );
            },
          );
        },
      ),
    );
  }
}
