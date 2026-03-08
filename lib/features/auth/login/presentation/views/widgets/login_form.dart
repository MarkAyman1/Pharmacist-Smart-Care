import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/widgets/evaluted_button.dart';
import 'package:pharmacist/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:pharmacist/features/auth/login/presentation/bloc/login_event.dart';
import 'package:pharmacist/features/auth/login/presentation/bloc/login_state.dart';
import 'package:pharmacist/features/auth/widgets/custom_textfeild_widget.dart';
import 'package:pharmacist/features/main/presentation/views/main_screen_view.dart';

import 'forgot_password_text.dart';
import 'dart:ui';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Login Success")));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainScreenView()),
          );
        }

        if (state is LoginFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(
                        label: "Email",
                        icon: Icons.email_outlined,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value!.isEmpty ? "Email is required" : null,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: "Password",
                        icon: Icons.lock_outline,
                        isPassword: true,
                        controller: passwordController,
                        validator: (value) =>
                            value!.isEmpty ? "Password is required" : null,
                      ),
                      ForgotPasswordText(onTap: () {}),
                      EvalutedButton(
                        text: state is Loginloading ? "Loading..." : "Login",
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                              LoginButtonPressed(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
