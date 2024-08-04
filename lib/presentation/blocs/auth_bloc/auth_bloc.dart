import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/domain/usecases/login_usecase.dart';
import 'package:taskly/domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;

  AuthBloc(this._loginUseCase, this._registerUseCase) : super(AuthInitialState()) {
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
