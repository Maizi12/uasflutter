import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:uas_flutter/constant/appconstants.dart';

class UserRepository {
  String url =
      '${AppConstants.MainUrl}${AppConstants.V1}${AppConstants.User}${AppConstants.Enkrip}';

  Future<Response> GetKey() async {
    print(url);
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64
        .encode('${AppConstants.BasicUsername}:${AppConstants.BasicPassword}');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "api-key": "ufr46B5waDi8dU0EgLuidOkJCrUkZQHY",
      "Authorization": "Basic $encoded",
      "timestamps": "abc",
      "xkey": "abc",
    };
    Response response = await http.get(
        Uri.http(AppConstants.MainUrl,
            '${AppConstants.V1}${AppConstants.User}${AppConstants.Enkrip}'),
        headers: header);

    return response;
  }
}


// Encrypted enkripemail = EncryptionData().encryptData(
//       "muhammadazzamshidqi935@gmail.com", "0XHBNPLHbC69H+DTXRAsiw==");
//   print(enkripemail.base64);
//   Encrypted enkrippass =
//       EncryptionData().encryptData("Testing123", "0XHBNPLHbC69H+DTXRAsiw==");
//   print(enkrippass.base64);

//   String jwt = BuatJwt().Create(
//       enkripemail.base64, enkrippass.base64, "0XHBNPLHbC69H+DTXRAsiw==");
//   print(jwt);