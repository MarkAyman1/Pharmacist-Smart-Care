import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';

class AppBackground {
  static BoxDecoration decoration({required bool isDark}) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: isDark
            ? [
                AppColors.darkGrey,
                AppColors.primaryDarkColor,
                AppColors.darkGrey,
              ]
            : [
                AppColors.lightGrey,
                AppColors.accentGreen.withValues(alpha: 0.4),
              ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }
}
