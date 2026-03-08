import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_color.dart';

class CompaniesHeader extends StatelessWidget {
  const CompaniesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose a company',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: isDark ? AppColors.darkOnSurface : AppColors.primaryDarkColor,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Browse products from your favorite pharma companies.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.7),
              ),
        ),
      ],
    );
  }
}