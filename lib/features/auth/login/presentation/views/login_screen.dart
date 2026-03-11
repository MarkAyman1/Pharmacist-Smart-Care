import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/api/dio_consumer.dart';
import 'package:pharmacist/features/auth/login/data/repo/login_repositry.dart';
import 'package:pharmacist/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:pharmacist/features/auth/login/presentation/views/widgets/bottom_widget.dart';
import 'package:pharmacist/features/auth/login/presentation/views/widgets/login_form.dart';
import 'package:pharmacist/features/auth/widgets/header_section.dart';
import 'package:pharmacist/features/auth/login/presentation/views/widgets/lottie_background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(LoginRepository(DioConsumer(Dio()))),
      child: LottieBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const HeaderSection(),
                const SizedBox(height: 100),
                const LoginForm(),
                const SizedBox(height: 100),
                BottomWidget(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
