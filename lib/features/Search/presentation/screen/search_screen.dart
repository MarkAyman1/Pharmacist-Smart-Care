import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/api/dio_consumer.dart';
import 'package:pharmacist/features/Search/presentation/screen/products_search_screen.dart';
import 'package:pharmacist/features/products/domain/repo/products_repository.dart';
import 'package:pharmacist/features/products/presentation/bloc/products_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsBloc(ProductsRepository(DioConsumer(Dio()))),
      child: const ProductsSearchScreen(),
    );
  }
}
