import 'package:taskly/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> signIn(String email, String password);

  Future<UserModel?> register(String email, String password);

  Future<UserModel?> signInWithGoogle();

  Future<UserModel?> registerWithGoogle();

  Future<void> signOut();
}
