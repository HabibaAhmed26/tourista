import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourista/core/di/di.dart';
import 'package:tourista/login.dart';
import 'package:tourista/presentation/features/authentication/cubit/authentication_cubit.dart';
import 'package:tourista/presentation/features/profile/view/profile.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: sl<FirebaseAuth>().authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print(snapshot.data);
          print(snapshot.connectionState);
          return CircularProgressIndicator(); // Show loading indicator
        } else if (snapshot.hasData && snapshot.data != null) {
          context.read<AuthenticationCubit>().setUser(snapshot.data!.uid);
          return Profile(); // User is logged in
        } else {
          return LoginPage(); // User is not logged in
        }
      },
    );
  }
}
