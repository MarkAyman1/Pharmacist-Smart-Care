import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacist/core/widgets/evaluted_button.dart';
import 'package:pharmacist/features/auth/login/presentation/views/login_screen.dart';
import 'package:pharmacist/features/auth/register/presentation/bloc/register_bloc.dart';
import 'package:pharmacist/features/auth/register/presentation/bloc/register_event.dart';
import 'package:pharmacist/features/auth/register/presentation/bloc/register_state.dart';
import 'package:pharmacist/features/auth/register/presentation/view/widgets/gender_dropdown.dart';
import 'dart:ui';
import 'package:pharmacist/features/auth/register/presentation/view/widgets/profile_image_picker_widget.dart';
import 'package:pharmacist/features/auth/register/presentation/view/widgets/store_dropdown.dart';
import 'package:pharmacist/features/auth/widgets/custom_textfeild_widget.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final licenceController = TextEditingController();

  String? gender;
  String? store;
  String? selectedStoreId;

  final List<String> genders = ['Male', 'Female'];

  XFile? pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        setState(() {
          pickedImage = image;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<RegisterBloc>().add(LoadStores());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Registration Successful!"),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );

          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          });
        }
      },
      child: Center(
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
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProfileImagePickerWidget(
                        imageFile: pickedImage,
                        onTap: _pickImage,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        label: "First Name",
                        icon: Icons.person,
                        controller: firstNameController,
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        label: "Last Name",
                        icon: Icons.person,
                        controller: lastNameController,
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        label: "Phone Number",
                        icon: Icons.phone,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 15),
                      GenderDropdown(
                        value: gender,
                        items: genders,
                        onChanged: (val) => setState(() => gender = val),
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        label: "Username",
                        icon: Icons.person_outline,
                        controller: usernameController,
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        label: "Email",
                        icon: Icons.email_outlined,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        label: "Password",
                        icon: Icons.lock_outline,
                        controller: passwordController,
                        isPassword: true,
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        label: "Licence Number",
                        icon: Icons.badge_outlined,
                        controller: licenceController,
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      const SizedBox(height: 15),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          if (state is StoresLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is StoresLoaded) {
                            return StoreDropdown(
                              value: store,
                              items: state.stores.map((e) => e.name).toList(),
                              onChanged: (val) {
                                setState(() {
                                  store = val;
                                  selectedStoreId = state.stores
                                      .firstWhere((s) => s.name == val)
                                      .id;
                                });
                              },
                            );
                          } else if (state is StoresFailure) {
                            return Text(
                              "Failed to load stores: ${state.error}",
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(height: 20),
                      EvalutedButton(
                        text: "Register",
                        onTap: () {
                          if (_formKey.currentState!.validate() &&
                              gender != null &&
                              selectedStoreId != null) {
                            final genderValue = gender == 'Male' ? 0 : 1;

                            context.read<RegisterBloc>().add(
                              RegisterSubmitted(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                username: usernameController.text,
                                phoneNumber: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                birthDate: "1999-9-9",
                                gender: genderValue,
                                profileImage: pickedImage!,
                                licenseNumber: licenceController.text,
                                storeId: selectedStoreId!,
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
        ),
      ),
    );
  }
}
