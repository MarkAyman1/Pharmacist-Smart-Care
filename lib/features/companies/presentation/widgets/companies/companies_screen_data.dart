import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/companies/presentation/bloc/companies_bloc.dart';
import 'package:pharmacist/features/companies/presentation/bloc/companies_state.dart';
import 'package:pharmacist/features/companies/presentation/widgets/companies/companies_header.dart';
import 'package:pharmacist/features/companies/presentation/widgets/companies/companies_grid.dart';

class CompaniesScreenData extends StatelessWidget {
  const CompaniesScreenData({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppThemes.customAppBar(
        title: 'Companies',
        showBackButton: false,
        isDarkMode: isDark,
      ),
      body: Container(
        decoration: AppBackground.decoration(isDark: isDark),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CompaniesHeader(),
                    const SizedBox(height: 16),
                    Expanded(
                      child: BlocBuilder<CompaniesBloc, CompaniesState>(
                        builder: (context, state) {
                          if (state is CompaniesLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is CompaniesLoaded) {
                            return CompaniesGrid(
                              companies: state.companies,
                            );
                          } else if (state is CompaniesError) {
                            return Center(child: Text(state.message));
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}