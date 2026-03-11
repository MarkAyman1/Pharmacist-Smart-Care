import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String username;
  final String phoneNumber;
  final String email;
  final String password;
  final int gender; // 0 = Male, 1 = Female
  final XFile? profileImage;
  final String licenseNumber;
  final String storeId;

  const RegisterSubmitted({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.gender,
    this.profileImage,
    required this.licenseNumber,
    required this.storeId,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    username,
    phoneNumber,
    email,
    password,
    gender,
    profileImage,
    licenseNumber,
    storeId,
  ];
}

class LoadStores extends RegisterEvent {}
