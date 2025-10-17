class UserModel {
  final String phoneNumber;
  final String password;

  UserModel({required this.phoneNumber, required this.password});

  // For serialization (if needed)
  Map<String, dynamic> toJson() => {
    'phoneNumber': phoneNumber,
    'password': password,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
    );
  }
}
