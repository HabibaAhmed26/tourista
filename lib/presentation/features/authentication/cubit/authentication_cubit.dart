import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tourista/core/di/di.dart';
import 'package:tourista/core/models/user_model.dart';
import 'package:tourista/core/network/fireauth/fire_auth.dart';
import 'package:tourista/core/network/firestore/firestore.dart';
import 'package:tourista/core/network/img%20service/img_service.dart';
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

  Future<void> googleSignIn() async {
    emit(Authenticationloading());
    try {
      // Sign in with Google
      final User? user = await _auth.signInWithGoogle();

      if (user == null) {
        emit(AuthenticationError(message: 'Google Sign-In cancelled'));
        return;
      }

      // Check if user profile already exists
      AppUser? appUser = await _firestore.getUserProfile(user.uid);

      if (appUser == null) {
        // Split display name into first and last name
        String firstName = '';
        String lastName = '';

        if (user.displayName != null) {
          final nameParts = user.displayName!.split(' ');
          firstName = nameParts.first;
          lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
        }

        // Create new user profile from Google data

        appUser = AppUser(
          uid: user.uid,
          email: user.email!,
          firstName: firstName,
          lastName: lastName,
          profilePictureUrl: user.photoURL,
        );

        await _firestore.createUserProfile(appUser);
      }

      emit(Authenticationloaded(currentUser: appUser));
    } catch (e) {
      print('❌ Google Sign-In error: $e');
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

  Future<void> refreshUserProfile() async {
    if (state is Authenticationloaded) {
      final currentState = state as Authenticationloaded;
      try {
        final updatedUser = await _firestore.getUserProfile(
          currentState.currentUser.uid!,
        );
        if (updatedUser != null) {
          emit(Authenticationloaded(currentUser: updatedUser));
        } else {
          emit(AuthenticationError(message: AppStrings.userNotFound));
        }
      } catch (e) {
        emit(AuthenticationError(message: e.toString()));
      }
    }
  }

  Future<void> updateUser(AppUser updatedUser) async {
    final currentState = state;
    if (currentState is! Authenticationloaded) {
      emit(AuthenticationError(message: 'No authenticated user found'));
      return;
    }

    emit(Authenticationloading());
    try {
      // Ensure we're using the current user's UID
      final userWithId = updatedUser.copyWith(
        uid: currentState.currentUser.uid,
      );
      await _firestore.updateUserProfile(userWithId);

      // Refresh the profile
      final refreshedUser = await _firestore.getUserProfile(userWithId.uid!);
      if (refreshedUser != null) {
        emit(Authenticationloaded(currentUser: refreshedUser));
      } else {
        throw Exception('Failed to refresh user profile after update');
      }
    } catch (e) {
      print('Error updating user: $e');
      emit(AuthenticationError(message: e.toString()));
    }
  }
}
