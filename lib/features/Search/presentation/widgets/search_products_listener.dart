import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_bloc.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_event.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_state.dart';

void handleSearchProductsListener(
  BuildContext context,
  ProductsState state,
  String currentSearchQuery,
) {
  if (state is StockUpdated) {
    // 1. Show Success Message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );

    // 2. Refresh Search Results
    if (currentSearchQuery.isNotEmpty) {
      context.read<ProductsBloc>().add(
            SearchProductsByNameEvent(productName: currentSearchQuery),
          );
    }
  } else if (state is ProductsError) {
    // Optional: Handle errors during stock update
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.message),
        backgroundColor: Colors.red,
      ),
    );
  }
}