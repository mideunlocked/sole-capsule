class UserDetails {
  final String email;
  final String username;
  final String fullName;
  final String password;
  final String profileImage;
  final String phoneNumber;

  const UserDetails({
    required this.email,
    required this.fullName,
    required this.username,
    required this.password,
    required this.phoneNumber,
    required this.profileImage,
  });

  factory UserDetails.fromJson({required Map<String, dynamic> json}) {
    return UserDetails(
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
      profileImage: json['profileImage'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  Map<String, dynamic> toJson({
    required String encryptedPassword,
    required String pProfileImage,
  }) {
    return {
      'email': email,
      'fullName': fullName,
      'password': encryptedPassword,
      'username': username,
      'profileImage': pProfileImage,
      'phoneNumber': phoneNumber,
    };
  }

  Map<String, dynamic> toUserDetailsJson({
    required String pUsername,
    required String pProfileImage,
    required String pPhoneNumber,
  }) {
    return {
      'email': email,
      'fullName': fullName,
      'password': password,
      'username': pUsername,
      'profileImage': pProfileImage,
      'phoneNumber': pPhoneNumber,
    };
  }
}
