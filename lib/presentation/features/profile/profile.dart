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
          return Scaffold(
            drawer: Drawer(),
            body: Column(
              children: [
                if (state is Authenticationloaded)
                  CircleAvatar(
                    child: Image.network(
                      state.currentUser.profilePictureUrl ?? "",
                      errorBuilder: (context, error, stackTrace) {
                        return CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.person,
                            color: Colors.grey[600],
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
