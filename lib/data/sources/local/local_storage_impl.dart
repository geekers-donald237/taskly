import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:taskly/data/models/user_model.dart';

import 'local_storage.dart';

class LocalStorageImpl extends LocalStorage {
  final GetStorage _storage = GetStorage();

  final _userKey = "userKey";
  final _tokenKey = "tokenKey";
  final _refreshKey = "refreshKey";
  final _imageQualityKey = "imageQualityKey";

  @override
  Future<void> saveUser(UserModel user) async {
    await _storage.write(_userKey, jsonEncode(user.toJson()));
  }

  @override
  UserModel? getUser() {
    var result = _storage.read<String?>(_userKey);
    if (result != null) {
      return UserModel.fromJson(jsonDecode(result));
    }
    return null;
  }

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  @override
  String? getToken() {
    return _storage.read<String?>(_tokenKey);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(_refreshKey, token);
  }

  @override
  String? getRefreshToken() {
    return _storage.read<String?>(_refreshKey);
  }

  @override
  String getAuthorization() {
    return "Bearer ${getToken()}";
  }

  @override
  bool isAnonymous() {
    var result = _storage.read<String?>(_userKey);
    if (result != null) {
      var user = UserModel.fromJson(jsonDecode(result));
      return (user.isAnonymous ?? false);
    }
    return false;
  }

  @override
  Future<void> deleteUser() async {
    await _storage.remove(_userKey);
    await _storage.remove(_tokenKey);
    await _storage.remove(_refreshKey);
  }

  @override
  bool areUserAgreementsAccepted() {
    return true;
  }

  @override
  Future<void> saveUserAgreementState(bool value) async {
    // _storage.write(_userAgreementKey, value);
  }
}
