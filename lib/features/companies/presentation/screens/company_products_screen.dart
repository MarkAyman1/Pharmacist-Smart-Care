import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/companies/presentation/bloc/companies_bloc.dart';
import 'package:pharmacist/features/companies/presentation/bloc/companies_event.dart';
import 'package:pharmacist/features/companies/presentation/bloc/companies_state.dart';
import 'package:pharmacist/features/products/presentation/products_list.dart';

class CompanyProductsScreen extends StatelessWidget {
  final String companyId;
  final String companyName;

  const CompanyProductsScreen({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) =>
          CompaniesBloc(context.read())
            ..add(FetchProductsByCompanyEvent(companyId: companyId)),
      child: Scaffold(
        appBar: AppThemes.customAppBar(
          title: companyName,
          showBackButton: true,
          isDarkMode: isDark,
        ),
        body: Container(
          decoration: AppBackground.decoration(isDark: isDark),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<CompaniesBloc, CompaniesState>(
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductsLoaded) {
                    final data = state.products;

                    return ProductsList(
                      products: data.items,
                      hasNext: data.hasNext,
                      currentPage: data.pageNumber,

                      onNext: () {
                        context.read<CompaniesBloc>().add(
                          FetchProductsByCompanyEvent(
                            companyId: companyId,
                            pageNumber: data.pageNumber + 1,
                          ),
                        );
                      },

                      onPrevious: () {
                        context.read<CompaniesBloc>().add(
                          FetchProductsByCompanyEvent(
                            companyId: companyId,
                            pageNumber: data.pageNumber - 1,
                          ),
                        );
                      },
                    );
                  } else if (state is CompaniesError) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
