import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tourista/core/di/di.dart';
import 'package:tourista/core/models/user_model.dart';
import 'package:tourista/core/network/fireauth/fire_auth.dart';
import 'package:tourista/core/network/firestore/firestore.dart';
import 'package:tourista/core/utils/app_strings.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final FireAuth _auth;
  final FireStore _firestore;
  AuthenticationCubit({required FireAuth auth, required FireStore firestore})
    : _auth = auth,
      _firestore = firestore,
      super(AuthenticationInitial());

  Future<void> signIn(String email, String password) async {
    emit(Authenticationloading());
    try {
      User? currentUser = await _auth.signIn(email, password);
      AppUser? user = await _firestore.getUserProfile(currentUser!.uid);
      if (user == null) {
        emit(AuthenticationError(message: AppStrings.userNotFound));
      }
      emit(Authenticationloaded(currentUser: user!));
    } catch (e) {
      emit(AuthenticationError(message: e.toString()));
    }
  }

  Future<void> signUp(AppUser newUser, String password) async {
    emit(Authenticationloading());
    AppUser? user;
    User? currentUser;
    try {
      currentUser = await _auth.signUp(newUser.email, password);
      newUser = newUser.copyWith(uid: currentUser?.uid);

      await _firestore.createUserProfile(newUser);

      user = await _firestore.getUserProfile(currentUser!.uid);
      if (user == null) {
        emit(AuthenticationError(message: AppStrings.userNotFound));
      }
      emit(Authenticationloaded(currentUser: user!));
    } catch (e) {
      // Delete user if any error occurs during profile creation
      if (user != null) {
        try {
          await _auth.deleteUser();
        } catch (deleteError) {
          print('Failed to delete user: $deleteError');
        }
      }
      emit(AuthenticationError(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(Authenticationloading());
    try {
      await _auth.signOut();
      emit(AuthenticationInitial());
    } catch (e) {
      emit(AuthenticationError(message: e.toString()));
    }
  }
}
