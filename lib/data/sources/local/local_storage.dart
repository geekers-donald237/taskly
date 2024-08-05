import 'package:taskly/data/models/user_model.dart';

abstract class LocalStorage {
  Future<void> saveUser(UserModel user);
  UserModel? getUser();
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> saveRefreshToken(String token);
  String? getRefreshToken();
  String getAuthorization();
  bool isAnonymous();
  Future<void> deleteUser();
  bool areUserAgreementsAccepted();
  Future<void> saveUserAgreementState(bool value);
}
