import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:taskly/presentation/blocs/app_bloc/app_bloc.dart';
import 'package:taskly/presentation/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:taskly/presentation/pages/auth/login_page.dart';
import 'package:taskly/presentation/pages/auth/login_page.dart';

import 'core/generics/gen/fonts.gen.dart';
import 'core/generics/gen/fonts.gen.dart';
import 'core/services/app_language/app_language.dart';
import 'core/services/app_language/app_language.dart';
import 'core/services/network/network_service.dart';
import 'core/services/notification/toast_service.dart';
import 'localization/app_localization.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(MyApp(appLanguage: appLanguage));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;

  const MyApp({required this.appLanguage});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
            create: (_) => ConnectivityBloc()..add(OnConnectivityEvent())),
        BlocProvider(create: (_) => AppBloc(appLanguage.appLocale)),
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
                        AppLocalizations.of(context)!.translate('connected_to_internet'),
                      );
                    } else if (state is ConnectivityFailureState) {
                      ToastService().showSnackbar(
                        context,
                        AppLocalizations.of(context)!.translate('lost_connection_to_internet'),
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
