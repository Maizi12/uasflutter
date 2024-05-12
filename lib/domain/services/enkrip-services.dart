import 'package:flutter/material.dart';
import 'package:uas_flutter/repositories/golang-repository.dart';

class EnkripServices {
  Future<dynamic> enkrip() {
    // print("service");
    return UserRepository().GetKey();
  }

  Future<dynamic> Login(String email, String password) {
    // final String email;
    // final String password;
    // print("service");
    return UserRepository().login(email, password);
    // Login({required this.email});
  }
}

final enkripServices = EnkripServices();
