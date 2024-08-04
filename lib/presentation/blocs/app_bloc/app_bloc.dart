import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(Locale locale) : super(AppState(locale: locale)) {
    on<LanguageChanged>(_onLanguageChanged);
  }

  void _onLanguageChanged(LanguageChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(locale: event.locale));
  }
}
