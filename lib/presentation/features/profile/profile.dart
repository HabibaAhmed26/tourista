import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourista/core/di/di.dart';
import 'package:tourista/presentation/features/authentication/cubit/authentication_cubit.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationCubit>(),
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state is Authenticationloaded) {
            return Scaffold(
              drawer: Drawer(),
              body: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          state.currentUser.profilePictureUrl?.isNotEmpty ==
                              true
                          ? NetworkImage(state.currentUser.profilePictureUrl!)
                          : null,
                      child:
                          state.currentUser.profilePictureUrl?.isNotEmpty ==
                              true
                          ? null
                          : Icon(
                              Icons.person,
                              color: Colors.grey[600],
                              size: 40,
                            ),
                    ),
                  ),
                  Text(state.currentUser.firstName),
                ],
              ),
            );
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          ;
        },
      ),
    );
  }
}
