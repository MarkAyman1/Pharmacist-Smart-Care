import 'package:flutter/material.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/companies/domain/models/company_model.dart';
import 'package:pharmacist/features/companies/presentation/widgets/companies/companies_header.dart';
import 'package:pharmacist/features/companies/presentation/widgets/companies/companies_grid.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppThemes.customAppBar(title: 'Companies', showBackButton: false, isDarkMode: isDark),
      body: Container(
        decoration: AppBackground.decoration(isDark: isDark),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CompaniesHeader(),
                const SizedBox(height: 16),
                Expanded(
                  child: CompaniesGrid(companies: mockCompanies),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}