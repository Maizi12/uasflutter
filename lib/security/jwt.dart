import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uas_flutter/security/constant.dart';

class BuatJwt {
  String Create(String email, String password, String key) {
    print("email Create " + email);
    return JWT({'email': email, 'password': password}).sign(
        SecretKey(EncryptionData.encryptionKeyGo + key),
        algorithm: JWTAlgorithm.HS256);
  }
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
