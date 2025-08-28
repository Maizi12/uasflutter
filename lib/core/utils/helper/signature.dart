import 'dart:convert';
class Signature {

String getBasicAuth(String username, String password) {
    final String cred = '$username:$password';
    print('ini username: $username');
    print('ini password: $password');
    final String basicAuth = 'Basic ${base64Encode(utf8.encode(cred))}';
    return basicAuth;
  }
}