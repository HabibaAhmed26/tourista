import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tourista/core/di/di.dart';
import 'package:tourista/core/theme/app_colors.dart';
import 'package:tourista/firebase_options.dart';
import 'package:tourista/login.dart';
import 'package:tourista/presentation/features/authentication/cubit/authentication_cubit.dart';
import 'package:tourista/presentation/features/authentication/view/sign_up.dart';

import 'Splash1.dart';
import 'Splash2.dart';
import 'Splash3.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<AuthenticationCubit>())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tourista App',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const OnboardingMain(),
      ),
    );
  }
}

class OnboardingMain extends StatefulWidget {
  const OnboardingMain({super.key});

  @override
  State<OnboardingMain> createState() => _OnboardingMainState();
}

class _OnboardingMainState extends State<OnboardingMain> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const OnboardingScreen(),
    const OnboardingScreen2(),
    const OnboardingScreen3(),
  ];

  void _nextPage() {
    if (_currentIndex < _screens.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to Login Page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView with your screens
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: _screens,
          ),

          // Skip button
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: _skipToLogin,
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Back button (only show after first page)
          if (_currentIndex > 0)
            Positioned(
              bottom: 30,
              left: 20,
              child: FloatingActionButton(
                heroTag: "backBtn",
                backgroundColor: Colors.grey.shade700,
                onPressed: _previousPage,
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),

          // Next button
          Positioned(
            bottom: 30,
            right: 20,
            child: FloatingActionButton(
              heroTag: "nextBtn",
              backgroundColor: Colors.blue,
              onPressed: _nextPage,
              child: Icon(
                _currentIndex == _screens.length - 1
                    ? Icons.check
                    : Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),

          // Page indicators
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _screens.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? Colors.blue
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
