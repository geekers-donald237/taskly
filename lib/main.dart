import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:taskly/presentation/pages/onboarding/first_onboard_page.dart';
import 'core/utils/gen/fonts.gen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(builder: (context, orientation, screenType) {
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
        themeMode: ThemeMode.dark,
        home: FirstOnboardPage(),
      );
    });
  }
}
