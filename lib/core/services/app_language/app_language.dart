import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageService {
  Locale _appLocale = const Locale('en');

  Locale get appLocale => _appLocale;

  Future<void> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      Locale systemLocale = WidgetsBinding.instance.window.locale;
      if (supportedLocales.contains(systemLocale)) {
        _appLocale = systemLocale;
      } else {
        _appLocale = const Locale('en');
      }
      return;
    }
    _appLocale = Locale(prefs.getString('language_code')!);
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale('fr')) {
      _appLocale = const Locale('fr');
      await prefs.setString('language_code', 'fr');
    } else {
      _appLocale = const Locale('en');
      await prefs.setString('language_code', 'en');
    }
  }

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('fr'),
  ];
}
