import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tourista/core/models/user_model.dart';
import 'package:tourista/core/network/firestore/firestore.dart';

class FireAuth {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  void _setupLocalization() {
    // Set based on device locale or default to English
    final locale = Platform.localeName.split('_').first;
    _auth.setLanguageCode(locale);
  }

  FireAuth({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  }) : _auth = firebaseAuth,
       _googleSignIn = googleSignIn;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;
  //Email signUp
  Future<User?> signUp(String email, String password) async {
    return (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
  }

  //Email signIn
  Future<User?> signIn(String email, String password) async {
    return (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
  }

  //signOut
  Future<void> signOut() => _auth.signOut();
  //Send Password Reset Email
  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email);
  //Update Password
  Future<void> updatePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user != null) await user.updatePassword(newPassword);
  }

  Future<String?> getIdToken() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return user.getIdToken();
  }

  //Delete User
  Future<void> deleteUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.delete();
    }
  }

  //signin with google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount gUser = await _googleSignIn.authenticate(
        scopeHint: ['email'],
      );

      // 2. Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await gUser.authentication;

      // 3. Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // 4. Once signed in, return the UserCredential
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return userCredential.user;
    } catch (e) {
      print('Google Sign-In error: $e');
      rethrow;
    }
  }

  Future<void> resetPassword(String email) {
    return (_auth.sendPasswordResetEmail(email: email));
  }
}
