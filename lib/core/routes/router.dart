import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourista/core/routes/router_constants.dart';
import 'package:tourista/login.dart';
import 'package:tourista/main.dart';
import 'package:tourista/presentation/features/authentication/view/reset_password.dart';
import 'package:tourista/presentation/features/authentication/view/sign_up.dart';
import 'package:tourista/presentation/features/home/view/home.dart';
import 'package:tourista/presentation/features/map/view/map.dart';
import 'package:tourista/presentation/features/profile/view/profile.dart';
import 'package:tourista/presentation/widgets/nav_bar.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouterConstants.onBoarding,
  routes: [
    GoRoute(
      path: RouterConstants.onBoarding,
      builder: (context, state) => const onBoarding(),
    ),
    GoRoute(
      path: RouterConstants.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RouterConstants.signup,
      builder: (context, state) => const SignUp(),
    ),
    GoRoute(
      path: RouterConstants.resetPassword,
      builder: (context, state) {
        return ResetPassword();
      },
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouterConstants.home,
              builder: (context, state) => HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouterConstants.profile,
              builder: (context, state) => Profile(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouterConstants.map,
              builder: (context, state) => MapPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
