import 'package:flutter/material.dart';

import '../colors_assets/colors.dart';
import 'onboarding_indicator.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.currentIndex,
    required this.itemCount,
    required this.onNext,
    required this.onSkip,
  });

  final String image;
  final String title;
  final String description;

  final int currentIndex;
  final int itemCount;

  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = currentIndex == itemCount - 1;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // =========================================
          // BIG IMAGE
          // =========================================

          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),

          // =========================================
          // TOP SKIP
          // =========================================

          if (!isLastPage)
            Positioned(
              top: MediaQuery.of(context).padding.top + 15,
              right: 24,
              child: GestureDetector(
                onTap: onSkip,
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

          // =========================================
          // BOTTOM WHITE CURVED CONTAINER
          // =========================================

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.28,
              padding: const EdgeInsets.fromLTRB(
                22,
                14,
                22,
                10,
              ),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // =================================
                  // DOTS
                  // =================================

                  OnboardingIndicator(
                    currentIndex: currentIndex,
                    itemCount: itemCount,
                  ),

                  const SizedBox(height: 18),

                  // =================================
                  // TITLE
                  // =================================

                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // =================================
                  // DESCRIPTION
                  // =================================

                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // =================================
                  // NEXT / GET STARTED BUTTON
                  // =================================

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: Text(
                        isLastPage ? 'Get Started' : 'Next',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // =================================
                  // SKIP
                  // =================================

                  if (!isLastPage) ...[
                    const SizedBox(height: 8),

                    GestureDetector(
                      onTap: onSkip,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}