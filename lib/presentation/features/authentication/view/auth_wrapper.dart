import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourista/core/di/di.dart';
import 'package:tourista/core/routes/router_constants.dart';
import 'package:tourista/login.dart';
import 'package:tourista/presentation/features/authentication/cubit/authentication_cubit.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: sl<FirebaseAuth>().authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ); // Show loading indicator
        } else if (snapshot.hasData && snapshot.data != null) {
          // Set the user in the cubit
          context.read<AuthenticationCubit>().setUser(snapshot.data!.uid);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(RouterConstants.profile);
          });

          // Return an empty scaffold while the router processes the navigation
          return const Scaffold();
        } else {
          return const LoginPage(); // User is not logged in
        }
      },
    );
  }
}
