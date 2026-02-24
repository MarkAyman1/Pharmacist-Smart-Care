import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';

class EvalutedButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double height;
  final double borderRadius;
  final List<Color>? gradientColors;
  final Color? shadowColor;

  const EvalutedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 55,
    this.borderRadius = 14,
    this.gradientColors,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> colors =
        gradientColors ??
        [
          AppColors.primaryblue.withValues(alpha: 0.9),
          AppColors.primaryLightColor.withValues(alpha: 0.9),
        ];

    final Color shadow =
        shadowColor ?? AppColors.primaryblue.withValues(alpha: 0.4);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: shadow,
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: Colors.white24,
          highlightColor: Colors.white10,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
