import 'package:flutter/material.dart';
import 'package:pharmacist/core/features/profile_drawer/models/profile_model.dart';
import 'package:pharmacist/core/features/profile_drawer/widgets/profile_info_card.dart';

class ProfileInfoList extends StatelessWidget {
  final ProfileModel? profile;

  const ProfileInfoList({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ProfileInfoCard(
          icon: Icons.email,
          title: 'Email',
          value: profile!.email,
        ),
        const SizedBox(height: 16),
        ProfileInfoCard(
          icon: Icons.phone,
          title: 'Phone Number',
          value: profile!.phoneNumber,
        ),
        const SizedBox(height: 16),
        ProfileInfoCard(
          icon: Icons.person,
          title: 'Gender',
          value: profile!.genderText,
        ),
        const SizedBox(height: 16),
        ProfileInfoCard(
          icon: Icons.badge,
          title: 'License Number',
          value: profile!.licenseNumber,
        ),
        const SizedBox(height: 16),
        ProfileInfoCard(
          icon: Icons.store,
          title: 'Store Name',
          value: profile!.storeName,
        ),
        const SizedBox(height: 16),
        ProfileInfoCard(
          icon: Icons.location_on,
          title: 'Store Address',
          value: profile!.storeAddress,
        ),
        const SizedBox(height: 16),
        ProfileInfoCard(
          icon: Icons.phone,
          title: 'Store Phone',
          value: profile!.storePhone,
        ),
      ],
    );
  }
}