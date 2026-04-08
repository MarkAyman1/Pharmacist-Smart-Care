import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_event.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_state.dart';
import 'package:pharmacist/features/products/presentation/products_list.dart';

import 'category_products_listener.dart';

class CategoryProductsBody extends StatelessWidget {
  final String categoryId;

  const CategoryProductsBody({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        handleCategoryProductsListener(context, state, categoryId);
      },
      builder: (context, state) {
        if (state is ProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        } 
        
        else if (state is ProductsLoaded) {
          return ProductsList(
            products: state.products.items,
            hasNext: state.products.hasNext,
            currentPage: state.products.pageNumber,

            // Next
            onNext: () {
              context.read<CategoriesBloc>().add(
                FetchProductsByCategoryEvent(
                  categoryId: categoryId,
                  pageNumber: state.products.pageNumber + 1,
                ),
              );
            },

            // Previous
            onPrevious: () {
              if (state.products.pageNumber > 1) {
                context.read<CategoriesBloc>().add(
                  FetchProductsByCategoryEvent(
                    categoryId: categoryId,
                    pageNumber: state.products.pageNumber - 1,
                  ),
                );
              }
            },
          );
        } 
        
        else if (state is CategoriesError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}