import 'package:flutter/material.dart';

class UserModel {
  final String phoneNumber;
  final String password;

  const UserModel({required this.phoneNumber, required this.password});

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

  UserModel copyWith({String? phoneNumber, String? password}) {
    return UserModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.phoneNumber == phoneNumber &&
        other.password == password;
  }

  @override
  int get hashCode => Object.hash(phoneNumber, password);

  @override
  String toString() =>
      'UserModel(phoneNumber: '
      '$phoneNumber, password: ****)';
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          },
          child: const Text('Go to Login'),
        ),
      ),
    );
  }
}
