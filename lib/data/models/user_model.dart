import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final bool? isAnonymous;
  final String? displayName;
  final String? photoURL;

  UserModel({
    required this.uid,
    required this.email,
    this.isAnonymous,
    this.displayName,
    this.photoURL,
  });

  // Crée une instance de UserModel à partir d'un User de Firebase
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email!,
      isAnonymous: user.isAnonymous,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }

  // Crée une instance de UserModel à partir d'un JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      isAnonymous: json['isAnonymous'],
      displayName: json['displayName'],
      photoURL: json['photoURL'],
    );
  }

  // Convertit une instance de UserModel en JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'isAnonymous': isAnonymous,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }
}
