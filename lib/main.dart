import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/taskly.dart';
import 'bloc_state_observer.dart';
import 'core/services/app_language/app_language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Bloc.observer = BlocStateOberver();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  runApp(
    Taskly(
      appLanguage: appLanguage,
      preferences: preferences,
    ),
  );
}
