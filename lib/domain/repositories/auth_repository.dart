import 'package:taskly/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> signIn(String email, String password);

  Future<User?> register(String email, String password);

  Future<void> signOut();
}
