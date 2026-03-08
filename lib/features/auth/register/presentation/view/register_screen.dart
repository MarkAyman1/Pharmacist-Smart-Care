import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/api/dio_consumer.dart';
import 'package:pharmacist/features/auth/register/data/repo/register_repository.dart';
import 'package:pharmacist/features/auth/register/presentation/bloc/register_bloc.dart';
import 'package:pharmacist/features/auth/widgets/header_section.dart';
import 'package:pharmacist/features/auth/login/presentation/views/widgets/lottie_background.dart';
import 'package:pharmacist/features/auth/register/presentation/view/widgets/bottom_widget.dart';
import 'package:pharmacist/features/auth/register/presentation/view/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = RegisterRepository(DioConsumer(Dio()));
    return BlocProvider(
      create: (context) => RegisterBloc(repository),
      child: LottieBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HeaderSection(),
                  const SizedBox(height: 50),
                  const RegisterForm(),
                  const SizedBox(height: 20),
                  BottomWidget(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
