import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacist/core/app_color.dart';
import 'package:pharmacist/core/features/profile_drawer/blocs/profile_bloc.dart';
import 'package:pharmacist/core/features/profile_drawer/blocs/profile_event.dart';
import 'package:pharmacist/core/features/profile_drawer/blocs/profile_state.dart';
import 'package:pharmacist/core/features/profile_drawer/widgets/profile_header.dart';
import 'package:pharmacist/core/features/profile_drawer/widgets/profile_info_list.dart';

class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({super.key, required this.child});

  final Widget child;

  static AdvancedDrawerController? controller;

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    ProfileDrawer.controller = _advancedDrawerController;
    // Load profile when drawer is initialized
    context.read<ProfileBloc>().add(LoadProfile());
  }

  void showDrawer() {
    _advancedDrawerController.showDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return AdvancedDrawer(
          backdrop: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryblue.withValues(alpha: 0.8),
                  AppColors.accentGreen.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
          controller: _advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          drawer: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  ProfileHeader(profile: state is ProfileLoaded ? state.profile : null),
                  const SizedBox(height: 30),

                  // Profile Information Cards
                  Expanded(
                    child: state is ProfileError
                        ? Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ProfileInfoList(profile: state is ProfileLoaded ? state.profile : null),
                  ),

                  // Footer
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified,
                          color: AppColors.accentGreen,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Licensed Pharmacist',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
