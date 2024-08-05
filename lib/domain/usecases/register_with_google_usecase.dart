import 'package:taskly/domain/repositories/auth_repository.dart';
import 'package:taskly/domain/entities/user.dart';

class RegisterWithGoogleUseCase {
  final AuthRepository _authRepository;

  RegisterWithGoogleUseCase(this._authRepository);

  Future<User?> call() async {
    final userModel = await _authRepository.registerWithGoogle();
    if (userModel == null) {
      return null;
    }
    return User(uid: userModel.uid, email: userModel.email, displayName: userModel.displayName);
  }
}
