abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterEvent(this.email, this.password);
}

class LogoutEvent extends AuthEvent {}

class SignInWithGoogleEvent extends AuthEvent {}

class RegisterWithGoogleEvent extends AuthEvent {}