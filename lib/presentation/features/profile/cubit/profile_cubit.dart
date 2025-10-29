import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:tourista/core/network/firestore/firestore.dart';
import 'package:tourista/core/network/img%20service/img_service.dart';
import 'package:tourista/core/utils/app_strings.dart';
import 'package:tourista/presentation/features/authentication/cubit/authentication_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required AuthenticationCubit authCubit,
    required ImgHosting hosting,
  }) : _authCubit = authCubit,

       _hosting = hosting,
       super(ProfileInitial());

  final AuthenticationCubit _authCubit;
  final ImgHosting _hosting;
  final ImagePicker picker = ImagePicker();

  Future<void> uploadProfilePicture(File imageFile) async {
    try {
      emit(ProfileUploadLoading());

      // Get current user
      final authState = _authCubit.state;
      if (authState is! Authenticationloaded) {
        emit(ProfileUploadError(AppStrings.userNotFound));
        return;
      }

      // Upload image to Imgbb
      String? imageUrl;
      try {
        imageUrl = await _hosting.uploadToImgBB(imageFile);
      } catch (e) {
        print('Error uploading to ImgBB: $e');
        emit(ProfileUploadError('Failed to upload image. Please try again.'));
        return;
      }

      if (imageUrl == null || imageUrl.isEmpty) {
        emit(ProfileUploadError('Failed to get image URL'));
        return;
      }

      // Update user profile in auth cubit
      try {
        final updatedUser = authState.currentUser.copyWith(
          profilePictureUrl: imageUrl,
        );
        await _authCubit.updateUser(updatedUser);

        // Check if update was successful
        final newAuthState = _authCubit.state;
        if (newAuthState is Authenticationloaded) {
          emit(ProfileUploadSuccess());
        } else if (newAuthState is AuthenticationError) {
          emit(ProfileUploadError(newAuthState.message));
        } else {
          emit(ProfileUploadError('Failed to update profile'));
        }
      } catch (e) {
        print('Error updating profile: $e');
        emit(ProfileUploadError('Failed to update profile: ${e.toString()}'));
      }
    } catch (e) {
      print('Error in uploadProfilePicture: $e');
      emit(ProfileUploadError(e.toString()));
    }
  }

  Future<void> deleteProfilePicture() async {
    try {
      emit(ProfileUploadLoading());

      // Get current user
      final authState = _authCubit.state;
      if (authState is! Authenticationloaded) {
        emit(ProfileUploadError(AppStrings.userNotFound));
        return;
      }

      try {
        // Update user profile in auth cubit
        final updatedUser = authState.currentUser.copyWith(
          profilePictureUrl: null,
        );
        await _authCubit.updateUser(updatedUser);

        // Check if update was successful
        final newAuthState = _authCubit.state;
        if (newAuthState is Authenticationloaded) {
          emit(ProfileUploadSuccess());
        } else if (newAuthState is AuthenticationError) {
          emit(ProfileUploadError(newAuthState.message));
        } else {
          emit(ProfileUploadError('Failed to update profile'));
        }
      } catch (e) {
        print('Error updating profile: $e');
        emit(ProfileUploadError('Failed to update profile: ${e.toString()}'));
      }
    } catch (e) {
      print('Error in deleteProfilePicture: $e');
      emit(ProfileUploadError(e.toString()));
    }
  }

  Future<void> selectImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text(AppStrings.chooseFromGallary),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 500,
                  maxHeight: 500,
                  imageQuality: 80,
                );
                if (image != null) {
                  await uploadProfilePicture(File(image.path));
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text(AppStrings.takePhoto),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                  maxWidth: 500,
                  maxHeight: 500,
                  imageQuality: 80,
                );
                if (image != null) {
                  await uploadProfilePicture(File(image.path));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
