import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/categories/presentation/widgets/categories/categories_header.dart';
import 'package:pharmacist/features/categories/presentation/widgets/categories/categories_grid.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_event.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_state.dart';

class CategoriesScreenData extends StatelessWidget {
  const CategoriesScreenData({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppThemes.customAppBar(
        title: 'Categories',
        showBackButton: false,
        isDarkMode: isDark,
      ),
      body: Container(
        decoration: AppBackground.decoration(isDark: isDark),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesInitial) {
                  context.read<CategoriesBloc>().add(FetchCategoriesEvent());
                  return const SizedBox.shrink();
                } else if (state is CategoriesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CategoriesLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CategoriesHeader(),
                      const SizedBox(height: 16),
                      Expanded(
                        child: CategoriesGrid(categories: state.categories),
                      ),
                    ],
                  );
                } else if (state is CategoriesError) {
                  return Center(child: Text(state.message));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
