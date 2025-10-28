import 'package:flutter/material.dart';
import 'package:tourista/core/utils/app_assets.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Image (Centered and clipped)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: 400,
                    height: 350,
                    child: Image.asset(
                      AppAssets
                          .splash3, // <-- Make sure this file exists in your assets folder
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Title
              const Text(
                "Let's enjoy ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 31, 74, 149),
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              const Text(
                "Enjoy your holiday’s and make amazing moments with your family and friends",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const Spacer(),

              // Page indicator and next button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
