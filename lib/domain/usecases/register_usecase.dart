import 'package:taskly/domain/repositories/auth_repository.dart';
import 'package:taskly/domain/entities/user.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<User?> call(String email, String password) async {
    final userModel = await _authRepository.register(email, password);
    if (userModel == null) {
      return null;
    }
    return User(uid: userModel.uid, email: userModel.email, displayName: userModel.displayName);
  }
}
