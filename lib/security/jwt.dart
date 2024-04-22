import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uas_flutter/security/constant.dart';

class BuatJwt {
  String Email;
  String Password;
  // String jwt="";
  BuatJwt({
    required this.Email,
    required this.Password,
  });
  // var email = "muhamadazzamshidqi935@gmail.com";
  BuatJwt.input(String email, String password)
      : Email = email,
        Password = password;
  String jwt = JWT({
    'email': generateMd5("muhamadazzamshidqi935@gmail.com"),
    'password': generateMd5("Testing123"),
  }).sign(SecretKey(EncryptionData.KEY + EncryptionData.encryptionKeyGo),
      algorithm: JWTAlgorithm.HS256);
  print(jwt) {
    // TODO: implement print
    print(jwt);
    // throw UnimplementedError();
  }
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
