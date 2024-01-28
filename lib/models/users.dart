class Users {
  final String id;
  final String email;
  final dynamic devices;
  final String username;
  final String fullName;
  final String password;
  final String profileImage;

  const Users({
    required this.id,
    required this.email,
    required this.devices,
    required this.fullName,
    required this.password,
    required this.username,
    required this.profileImage,
  });

  factory Users.fromJson({required Map<String, dynamic> json}) {
    return Users(
      id: json['id'] as String,
      email: json['email'] as String,
      devices: json['devices'] as String,
      fullName: json['fullName'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
      profileImage: json['profileImage'] as String,
    );
  }

  Map<String, dynamic> toJson({required Users user}) {
    return {
      'id': user.id,
      'email': user.email,
      'devices': user.devices,
      'fullName': user.fullName,
      'password': user.password,
      'username': user.username,
      'profileImage': user.profileImage,
    };
  }
}
