import 'package:uas_flutter/repositories/golang-repository.dart';

class EnkripServices {
  Future<dynamic> enkrip() {
    // print("service");
    return UserRepository().GetKey();
  }
}

final enkripServices = EnkripServices();
