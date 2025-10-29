import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourista/presentation/features/authentication/cubit/authentication_cubit.dart';
import 'package:tourista/presentation/features/profile/cubit/profile_cubit.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is! Authenticationloaded) {
          return const SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(),
          );
        }

        return Stack(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  state.currentUser.profilePictureUrl?.isNotEmpty == true
                  ? NetworkImage(state.currentUser.profilePictureUrl!)
                  : null,
              child: state.currentUser.profilePictureUrl?.isNotEmpty == true
                  ? null
                  : Icon(Icons.person, color: Colors.grey[600], size: 40),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () =>
                      context.read<ProfileCubit>().selectImage(context),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
