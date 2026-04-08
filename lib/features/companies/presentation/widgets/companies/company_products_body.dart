import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_bloc.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_event.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_state.dart';
import 'package:pharmacist/features/products/presentation/widgets/products_list.dart';
import 'company_products_listener.dart';

class CompanyProductsBody extends StatelessWidget {
  final String companyId;

  const CompanyProductsBody({
    super.key,
    required this.companyId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        handleCompanyProductsListener(context, state, companyId);
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
              context.read<ProductsBloc>().add(
                FetchProductsByCompanyEvent(
                  companyId: companyId,
                  pageNumber: state.products.pageNumber + 1,
                ),
              );
            },

            // Previous
            onPrevious: () {
              if (state.products.pageNumber > 1) {
                context.read<ProductsBloc>().add(
                  FetchProductsByCompanyEvent(
                    companyId: companyId,
                    pageNumber: state.products.pageNumber - 1,
                  ),
                );
              }
            },
          );
        } 
        
        else if (state is ProductsError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}