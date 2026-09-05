import 'dart:async';

import 'package:flutter/material.dart';

import 'package:ma/colors_assets//assets.dart';
import 'package:ma/colors_assets/colors.dart';
import 'package:ma/onboarding/onboarding_screen.dart';
import 'splash_loading.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(
      const Duration(seconds: 2),
      _goToOnboarding,
    );
  }

  void _goToOnboarding() {
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const OnboardingScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.logo,
              width: 250,
            ),

            const SizedBox(height: 40),

            const SplashLoading(
              size: 60,
              strokeWidth: 6,
            ),
          ],
        ),
      ),
    );
  }
}