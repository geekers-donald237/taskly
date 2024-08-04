part of 'app_bloc.dart';

class AppState extends Equatable {
  final Locale locale;

  const AppState({required this.locale});

  AppState copyWith({Locale? locale}) {
    return AppState(locale: locale ?? this.locale);
  }

  @override
  List<Object> get props => [locale];
}
