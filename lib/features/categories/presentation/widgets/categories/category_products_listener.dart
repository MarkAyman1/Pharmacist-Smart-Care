import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_event.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_state.dart';

void handleCategoryProductsListener(
  BuildContext context,
  CategoriesState state,
  String categoryId,
) {
  if (state is StockUpdated) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );

    final currentState = context.read<CategoriesBloc>().state;

    if (currentState is ProductsLoaded) {
      context.read<CategoriesBloc>().add(
        FetchProductsByCategoryEvent(
          categoryId: categoryId,
          pageNumber: currentState.products.pageNumber,
        ),
      );
    }
  }
}