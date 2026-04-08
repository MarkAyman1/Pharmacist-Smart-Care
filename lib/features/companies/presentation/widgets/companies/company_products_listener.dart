import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_bloc.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_event.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_state.dart';

void handleCompanyProductsListener(
  BuildContext context,
  ProductsState state,
  String companyId,
) {
  if (state is StockUpdated) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
      ),
    );

    final currentState = context.read<ProductsBloc>().state;

    if (currentState is ProductsLoaded) {
      context.read<ProductsBloc>().add(
        FetchProductsByCompanyEvent(
          companyId: companyId,
          pageNumber: currentState.products.pageNumber,
        ),
      );
    }
  }
}