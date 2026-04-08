import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/api/dio_consumer.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/categories/domain/repo/categories_repository.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_event.dart';
import 'package:pharmacist/features/categories/presentation/widgets/categories/category_products_body.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const CategoryProductsScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (_) =>
          CategoriesBloc(CategoriesRepository(DioConsumer(Dio())))
            ..add(FetchProductsByCategoryEvent(categoryId: categoryId)),
      child: Scaffold(
        appBar: AppThemes.customAppBar(
          title: categoryName,
          showBackButton: true,
          isDarkMode: isDark,
        ),
        body: Container(
          decoration: AppBackground.decoration(isDark: isDark),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CategoryProductsBody(categoryId: categoryId),
            ),
          ),
        ),
      ),
    );
  }
}
