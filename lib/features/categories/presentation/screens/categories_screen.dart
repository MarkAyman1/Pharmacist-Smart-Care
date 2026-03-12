import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/features/categories/domain/repo/categories_repository.dart';
import 'package:pharmacist/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:pharmacist/core/api/dio_consumer.dart';
import 'package:pharmacist/features/categories/presentation/widgets/categories/categories_screen_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoriesBloc(CategoriesRepository(DioConsumer(Dio()))),
      child: const CategoriesScreenData(),
    );
  }
}
