import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/app_theme.dart';
import 'package:pharmacist/core/styles/app_background.dart';
import 'package:pharmacist/features/companies/presentation/widgets/companies/company_products_body.dart';
import 'package:pharmacist/features/products/domain/repo/products_repository.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_bloc.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_event.dart';
import 'package:pharmacist/core/api/dio_consumer.dart';

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
      create: (_) =>
          ProductsBloc(ProductsRepository(DioConsumer(Dio())))
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
              child: CompanyProductsBody(companyId: companyId),
            ),
          ),
        ),
      ),
    );
  }
}