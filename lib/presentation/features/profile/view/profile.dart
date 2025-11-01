import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourista/core/di/di.dart';
import 'package:tourista/core/routes/router_constants.dart';
import 'package:tourista/core/utils/app_strings.dart';
import 'package:tourista/login.dart';
import 'package:tourista/presentation/features/authentication/cubit/authentication_cubit.dart';
import 'package:tourista/presentation/features/profile/cubit/profile_cubit.dart';
import 'package:tourista/presentation/features/profile/widgets/profile_picture.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUploadSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            } else if (state is ProfileUploadError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        buildWhen: (previous, current) =>
            previous is Authenticationloaded && current is Authenticationloaded
            ? previous.currentUser != current.currentUser
            : true,
        builder: (context, authState) {
          if (authState is Authenticationloaded) {
            return BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, profileState) {
                return Scaffold(
                  drawer: const Drawer(),
                  body: Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 60),
                          const Center(child: ProfilePicture()),
                          const SizedBox(height: 16),
                          Text(
                            authState.currentUser.firstName,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              try {
                                context.read<AuthenticationCubit>().signOut();
                                context.go(RouterConstants.login);
                              } catch (e) {
                                print('Error signing out: $e');
                              }
                            },
                            child: Text(AppStrings.signOut),
                          ),
                        ],
                      ),
                      if (profileState is ProfileUploadLoading)
                        Container(
                          color: Colors.black26,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          }

          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
