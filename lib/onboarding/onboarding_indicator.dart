import 'package:flutter/material.dart';

import '../colors_assets/colors.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  final int currentIndex;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
            (index) {
          final bool isActive = index == currentIndex;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 28 : 7,
            height: 7,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.lightGrey,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}