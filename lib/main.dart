import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:taskly/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:taskly/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:taskly/presentation/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:taskly/presentation/pages/auth/login_page.dart';

import 'core/generics/gen/fonts.gen.dart';
import 'core/services/app_language/app_language.dart';
import 'core/services/firebase/firebase_auth_service.dart';
import 'core/services/notification/toast_service.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/register_usecase.dart';
import 'localization/app_localization.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialiser Firebase
  await Firebase.initializeApp();

  AppLanguageService appLanguage = AppLanguageService();
  await appLanguage.fetchLocale();

  runApp(MyApp(appLanguage: appLanguage));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final AppLanguageService appLanguage;

  const MyApp({required this.appLanguage});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService firebaseAuthService =
        FirebaseAuthService(FirebaseAuth.instance);
    final AuthRepositoryImpl authRepository =
        AuthRepositoryImpl(firebaseAuthService);
    final LoginUseCase loginUseCase = LoginUseCase(authRepository);
    final RegisterUseCase registerUseCase = RegisterUseCase(authRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppBloc(appLanguage.appLocale),
        ),
        BlocProvider(
          create: (_) => AuthBloc(loginUseCase, registerUseCase),
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
                  fontFamily: FontFamily.satoshi,
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
                  fontFamily: FontFamily.satoshi,
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
                builder: EasyLoading.init(),
                home: BlocListener<ConnectivityBloc, ConnectivityState>(
                  listener: (context, state) {
                    if (state is ConnectivitySuccessState) {
                      ToastService().showSnackbar(
                        context,
                        AppLocalizations.of(context)!
                            .translate('connected_to_internet'),
                      );
                    } else if (state is ConnectivityFailureState) {
                      ToastService().showSnackbar(
                        context,
                        AppLocalizations.of(context)!
                            .translate('lost_connection_to_internet'),
                        isError: true,
                      );
                    }
                  },
                  child: const LoginPage(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
