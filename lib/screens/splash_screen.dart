import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:solulab5/screens/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/splash_screen.json'),
      backgroundColor: const Color(0xff0C8A7B),
      nextScreen: const OnboardingScreen(),
      splashIconSize: 300,
      duration: 4000,
    );
  }
}
