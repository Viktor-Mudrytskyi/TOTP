import 'dart:math';

import 'package:flutter/material.dart';

class ClockIndicatorPainter extends CustomPainter {
  ClockIndicatorPainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });

  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    // Create the background circle paint
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0;

    // Draw the background circle
    canvas.drawCircle(center, radius, backgroundPaint);

    // Create the progress indicator paint
    final foregroundPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0;

    // Define the angle for the progress
    final sweepAngle = 2 * pi * progress;

    // Draw the progress arc
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, sweepAngle, true, foregroundPaint);
  }

  @override
  bool shouldRepaint(ClockIndicatorPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor;
  }
}

class ClockIndicator extends StatelessWidget {
  const ClockIndicator({
    super.key,
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ClockIndicatorPainter(
        progress: progress,
        backgroundColor: backgroundColor,
        progressColor: progressColor,
      ),
    );
  }
}
