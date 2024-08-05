import 'package:taskly/domain/repositories/auth_repository.dart';
import 'package:taskly/domain/entities/user.dart';

class SignInWithGoogleUseCase {
  final AuthRepository _authRepository;

  SignInWithGoogleUseCase(this._authRepository);

  Future<User?> call() async {
    final userModel = await _authRepository.signInWithGoogle();
    if (userModel == null) {
      return null;
    }
    return User(uid: userModel.uid, email: userModel.email, displayName: userModel.displayName);
  }
}
