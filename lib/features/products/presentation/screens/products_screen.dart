import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/api/dio_consumer.dart';
import 'package:pharmacist/features/products/domain/model/product_model.dart';
import 'package:pharmacist/features/products/domain/repo/products_repository.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_bloc.dart';
import 'package:pharmacist/features/products/presentation/widgets/products_list.dart';

class ProductsScreen extends StatelessWidget {
  final List<ProductModel> products;
  final bool hasNext;
  final int currentPage;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final Future<void> Function()? onRefresh;

  const ProductsScreen({
    super.key,
    required this.products,
    required this.hasNext,
    required this.currentPage,
    required this.onNext,
    required this.onPrevious,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsBloc(ProductsRepository(DioConsumer(Dio()))),
      child: Scaffold(
        appBar: AppBar(title: const Text("Products")),
        body: ProductsList(
          products: products,
          hasNext: hasNext,
          currentPage: currentPage,
          onRefresh: onRefresh,
          onNext: onNext,
          onPrevious: onPrevious,
        ),
      ),
    );
  }
}
