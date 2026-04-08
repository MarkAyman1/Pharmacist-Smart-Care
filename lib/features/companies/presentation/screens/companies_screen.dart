import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/api/dio_consumer.dart';
import 'package:pharmacist/features/companies/domain/repo/companies_repository.dart';
import 'package:pharmacist/features/companies/presentation/bloc/companies_bloc.dart';
import 'package:pharmacist/features/companies/presentation/bloc/companies_event.dart';
import 'package:pharmacist/features/companies/presentation/widgets/companies/companies_screen_data.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CompaniesBloc(CompaniesRepository(DioConsumer(Dio())))
            ..add(FetchCompaniesEvent()),
      child: const CompaniesScreenData(),
    );
  }
}
