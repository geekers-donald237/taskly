import 'package:taskly/domain/entities/user.dart';
import 'package:taskly/domain/repositories/auth_repository.dart';

import '../../core/services/firebase/firebase_auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepositoryImpl(this._firebaseAuthService);

  @override
  Future<User?> signIn(String email, String password) async {
    final user =
        await _firebaseAuthService.signInWithEmailAndPassword(email, password);
    return user != null
        ? User(uid: user.uid, email: user.email!, displayName: user.displayName)
        : null;
  }

  @override
  Future<User?> register(String email, String password) async {
    final user = await _firebaseAuthService.registerWithEmailAndPassword(
        email, password);
    return user != null
        ? User(uid: user.uid, email: user.email!, displayName: user.displayName)
        : null;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuthService.signOut();
  }
}
