class ProfileModel {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String phoneNumber;
  final int gender; // 0 for male, 1 for female?
  final String profileImageUrl;
  final String licenseNumber;
  final bool isActive;
  final String storeId;
  final String storeName;
  final String storeAddress;
  final String storePhone;

  ProfileModel({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.profileImageUrl,
    required this.licenseNumber,
    required this.isActive,
    required this.storeId,
    required this.storeName,
    required this.storeAddress,
    required this.storePhone,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'] ?? 0,
      profileImageUrl: json['profileImageUrl'] ?? '',
      licenseNumber: json['licenseNumber'] ?? '',
      isActive: json['isActive'] ?? true,
      storeId: json['storeId'] ?? '',
      storeName: json['storeName'] ?? '',
      storeAddress: json['storeAddress'] ?? '',
      storePhone: json['storePhone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'profileImageUrl': profileImageUrl,
      'licenseNumber': licenseNumber,
      'isActive': isActive,
      'storeId': storeId,
      'storeName': storeName,
      'storeAddress': storeAddress,
      'storePhone': storePhone,
    };
  }

  String get fullName => '$firstName $lastName';

  String get genderText => gender == 0 ? 'Male' : 'Female';
}
