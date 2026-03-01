import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';

class CustomBottomWidget extends StatelessWidget {
  final String message;
  final String actionText;
  final VoidCallback onActionTap;

  const CustomBottomWidget({
    super.key,
    required this.message,
    required this.actionText,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.darkMediumGrey : AppColors.mediumGrey,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 6),

          InkWell(
            onTap: onActionTap,
            borderRadius: BorderRadius.circular(6),
            splashColor: colorScheme.primary.withValues(alpha: 0.15),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
              child: Text(
                actionText,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
