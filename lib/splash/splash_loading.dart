import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:ma/colors_assets/colors.dart';

class SplashLoading extends StatefulWidget {
  const SplashLoading({
    super.key,
    this.size = 65,
    this.strokeWidth = 6,
  });

  final double size;
  final double strokeWidth;

  @override
  State<SplashLoading> createState() => _SplashLoadingState();
}

class _SplashLoadingState extends State<SplashLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * math.pi * 2,
          child: CustomPaint(
            size: Size.square(widget.size),
            painter: _LoadingPainter(
              strokeWidth: widget.strokeWidth,
            ),
          ),
        );
      },
    );
  }
}

class _LoadingPainter extends CustomPainter {
  const _LoadingPainter({
    required this.strokeWidth,
  });

  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius =
        (size.shortestSide - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = AppColors.white.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Background circle
    canvas.drawCircle(
      center,
      radius,
      backgroundPaint,
    );

    // Loading arc
    const startAngle = -math.pi / 2;
    const sweepAngle = math.pi * 1.25;

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(
      covariant _LoadingPainter oldDelegate,
      ) {
    return oldDelegate.strokeWidth != strokeWidth;
  }
}