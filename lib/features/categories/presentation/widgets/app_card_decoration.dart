import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';

class AppCardDecorations {
  static BoxDecoration categoryCard({bool isDark = false}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: isDark
            ? [
                Color(0xFF4A90E2),
                AppColors.primaryblue,
                AppColors.accentGreen.withValues(alpha: 0.4),
              ]
            : [
                AppColors.white,
                AppColors.accentGreen.withValues(alpha: 0.6),
                AppColors.primaryblue.withValues(alpha: 0.3),
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.08),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
        if (!isDark)
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(-2, -2),
          ),
      ],
    );
  }

  /// Inner image overlay
  static BoxDecoration imageOverlay({bool isDark = false}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        colors: isDark
            ? [
                Color(0x664A90E2), // أزرق سماوي شفاف
                AppColors.primaryblue.withValues(alpha: 0.6),
                AppColors.accentGreen.withValues(alpha: 0.2),
              ]
            : [
                AppColors.primaryblue.withValues(alpha: 0.8),
                AppColors.primaryLightColor.withValues(alpha: 0.8),
                AppColors.accentGreen.withValues(alpha: 0.2),
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }
}
