import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_bloc.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_event.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_state.dart';
import 'package:pharmacist/features/products/presentation/widgets/products_list.dart';

import 'category_products_listener.dart';

class CategoryProductsBody extends StatelessWidget {
  final String categoryId;

  const CategoryProductsBody({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        handleCategoryProductsListener(context, state, categoryId);
      },
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductsLoaded) {
          return ProductsList(
            products: state.products.items,
            hasNext: state.products.hasNext,
            currentPage: state.products.pageNumber,
            onRefresh: () async {
              context.read<ProductsBloc>().add(
                FetchProductsByCategoryEvent(
                  categoryId: categoryId,
                  pageNumber: state.products.pageNumber,
                ),
              );

              await context.read<ProductsBloc>().stream.firstWhere(
                (state) => state is ProductsLoaded || state is ProductsError,
              );
            },

            // Next
            onNext: () {
              context.read<ProductsBloc>().add(
                FetchProductsByCategoryEvent(
                  categoryId: categoryId,
                  pageNumber: state.products.pageNumber + 1,
                ),
              );
            },

            // Previous
            onPrevious: () {
              if (state.products.pageNumber > 1) {
                context.read<ProductsBloc>().add(
                  FetchProductsByCategoryEvent(
                    categoryId: categoryId,
                    pageNumber: state.products.pageNumber - 1,
                  ),
                );
              }
            },
          );
        } else if (state is ProductsError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}
