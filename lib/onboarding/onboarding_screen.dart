import 'package:flutter/material.dart';

import '../colors_assets/assets.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'image': AppAssets.onboarding1,
      'title': 'Stay Informed.',
      'description':
      'Get the latest news from around the world delivered to your fingertips.',
    },
    {
      'image': AppAssets.onboarding2,
      'title': 'Personalized for You',
      'description':
      'Customize your feed to follow the topics and sources you care about most.',
    },
    {
      'image': AppAssets.onboarding3,
      'title': 'Read Anywhere',
      'description':
      'Save articles to read later and stay updated even when you are offline.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Get Started
    }
  }

  void _skipOnboarding() {
    _pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,

        // ممنوع الـ Swipe
        physics: const NeverScrollableScrollPhysics(),

        itemCount: _pages.length,

        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        itemBuilder: (context, index) {
          final page = _pages[index];

          return OnboardingPage(
            image: page['image']!,
            title: page['title']!,
            description: page['description']!,
            currentIndex: _currentIndex,
            itemCount: _pages.length,
            onNext: _nextPage,
            onSkip: _skipOnboarding,
          );
        },
      ),
    );
  }
}