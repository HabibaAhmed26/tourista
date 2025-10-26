import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourista/core/models/user_model.dart';
import 'package:tourista/core/network/firestore/firestore.dart';

class FireAuth {
  final FirebaseAuth _auth;

  FireAuth({required FirebaseAuth firebaseAuth, required FireStore firestore})
    : _auth = firebaseAuth;
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;
  Future<User?> signUp(String email, String password) async {
    return (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
  }

  Future<User?> signIn(String email, String password) async {
    return (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
  }

  Future<void> signOut() => _auth.signOut();

  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email);

  Future<void> updatePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user != null) await user.updatePassword(newPassword);
  }

  Future<String?> getIdToken() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return user.getIdToken();
  }
}
