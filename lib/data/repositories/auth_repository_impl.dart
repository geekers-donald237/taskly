import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskly/data/models/user_model.dart';
import 'package:taskly/domain/repositories/auth_repository.dart';

import '../sources/local/local_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final LocalStorage _localStorage;

  AuthRepositoryImpl(this._firebaseAuth, this._localStorage);

  @override
  Future<UserModel?> signIn(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final User? user = userCredential.user;

    if (user != null) {
      final UserModel userModel = UserModel.fromFirebaseUser(user);
      await _localStorage.saveUser(userModel);
      await _localStorage.saveToken(user.uid);
      return userModel;
    }

    return null;
  }

  @override
  Future<UserModel?> register(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final User? user = userCredential.user;

    if (user != null) {
      final UserModel userModel = UserModel.fromFirebaseUser(user);
      await _localStorage.saveUser(userModel);
      await _localStorage.saveToken(user.uid);
      return userModel;
    }

    return null;
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      final UserModel userModel = UserModel.fromFirebaseUser(user);
      await _localStorage.saveUser(userModel);
      await _localStorage.saveToken(user.uid);
      return userModel;
    }

    return null;
  }

  @override
  Future<UserModel?> registerWithGoogle() async {
    return signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
    await _localStorage.deleteUser();
  }
}
