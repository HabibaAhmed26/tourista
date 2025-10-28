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
      child: Center(
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is Authenticationloaded) {
              return Text("Welcome, ${state.currentUser.firstName}");
            } else if (state is Authenticationloading) {
              return const CircularProgressIndicator();
            } else {
              return const Text("Please log in.");
            }
          },
        ),
      ),
    );
  }
}
