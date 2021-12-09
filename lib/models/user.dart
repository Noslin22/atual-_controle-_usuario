import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String password;
  final String cargo;
  final String avatarUrl;

  const User({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.cargo,
    this.avatarUrl,
  });

  Map<String, String> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'cargo': cargo,
      'avatarUrl': avatarUrl,
    };
  }
}
