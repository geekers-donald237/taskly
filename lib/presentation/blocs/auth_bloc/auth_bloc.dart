import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/domain/usecases/login_usecase.dart';
import 'package:taskly/domain/usecases/register_usecase.dart';
import 'package:taskly/data/sources/local/local_storage.dart';
import 'package:taskly/domain/entities/user.dart' as MyAppUser; // Alias pour éviter le conflit
import 'package:taskly/domain/usecases/logout_usecase.dart';
import 'package:taskly/domain/usecases/register_with_google_usecase.dart';
import 'package:taskly/domain/usecases/sign_in_with_google_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final LocalStorage _localStorage;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final RegisterWithGoogleUseCase _registerWithGoogleUseCase;

  AuthBloc(
      this._loginUseCase,
      this._registerUseCase,
      this._logoutUseCase,
      this._signInWithGoogleUseCase,
      this._registerWithGoogleUseCase,
      this._localStorage)
      : super(AuthInitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final user = await _loginUseCase.call(event.email, event.password);
        if (user != null) {
          emit(AuthSuccessState(user));
        } else {
          emit(const AuthFailureState('invalid_email_or_password'));
        }
      } catch (e) {
        if (e is FirebaseAuthException) {
          emit(AuthFailureState(_mapFirebaseAuthErrorToMessage(e.code)));
        } else {
          emit(AuthFailureState(e.toString()));
        }
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final user = await _registerUseCase.call(event.email, event.password);
        if (user != null) {
          emit(AuthSuccessState(user));
        } else {
          emit(const AuthFailureState('registration_failed'));
        }
      } catch (e) {
        if (e is FirebaseAuthException) {
          emit(AuthFailureState(_mapFirebaseAuthErrorToMessage(e.code)));
        } else {
          emit(AuthFailureState(e.toString()));
        }
      }
    });

    on<SignInWithGoogleEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final MyAppUser.User? user = await _signInWithGoogleUseCase.call();
        if (user != null) {
          emit(AuthSuccessState(user));
        } else {
          emit(const AuthFailureState('google_sign_in_failed'));
        }
      } catch (e) {
        emit(AuthFailureState(e.toString()));
      }
    });

    on<RegisterWithGoogleEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        final MyAppUser.User? user = await _registerWithGoogleUseCase.call();
        if (user != null) {
          emit(AuthSuccessState(user));
        } else {
          emit(const AuthFailureState('google_register_failed'));
        }
      } catch (e) {
        emit(AuthFailureState(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      await _localStorage.deleteUser();
      emit(AuthInitialState());
    });
  }

  String _mapFirebaseAuthErrorToMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-credential':
      case 'user-not-found':
      case 'wrong-password':
        return 'invalid_email_or_password';
      case 'email-already-in-use':
        return 'email_already_in_use';
      case 'weak-password':
        return 'weak_password';
      default:
        return 'unknown_error';
    }
  }
}
