import 'dart:async';
import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:dio/dio.dart';

import 'package:uas_flutter/constant/appconstants.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/security/constant.dart';
import 'package:uas_flutter/security/jwt.dart';

class ResponseEnkrip {
  String ResponseCode;
  Map<String, dynamic> Key;
  ResponseEnkrip({
    required this.ResponseCode,
    required this.Key,
  });
  factory ResponseEnkrip.KeyfromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "responseCode": String ResponseCode,
        "data": Map<String, dynamic> Key,
      } =>
        ResponseEnkrip(ResponseCode: ResponseCode, Key: Key),
      _ => throw const FormatException('Failed to load key.'),
    };
  }
}

class UserRepository {
  UserRepository() {
    _dio = Dio();
    _dio.options.validateStatus = (int? status) {
      return status! >= 200 && status < 500;
    };
  }

  late ResponseEnkrip getkey;
  late Dio _dio;

  String url =
      '${AppConstants.MainUrl}${AppConstants.V1}${AppConstants.User}${AppConstants.Enkrip}';

  Future<dynamic> GetKey() async {
    try {
      // print(url);
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String encoded = stringToBase64.encode(
          '${AppConstants.BasicUsername}:${AppConstants.BasicPassword}');
      Map<String, String> header = {
        // 'Content-type': 'application/json',
        // 'Accept': 'application/json',
        "api-key": "ufr46B5waDi8dU0EgLuidOkJCrUkZQHY",
        "Authorization": "Basic $encoded",
        "timestamps": "abc",
        "xkey": "abc",
      };

      Response response = await _dio.getUri(
          Uri.http("192.168.1.3:80",
              "${AppConstants.V1}${AppConstants.User}${AppConstants.Enkrip}"),
          options: Options(headers: header));

      return response.data;
    } on DioException catch (e) {
      return MetaModel(message: e.toString(), code: "201", data: null);
    } catch (e) {
      return MetaModel(message: e.toString(), code: "201", data: null);
    }
  }

  ResponseEnkrip key() {
    getkey.ResponseCode = "";
    print("getkey key");
    print(getkey);
    // GetKey().then((value) => getkey);
    return getkey;
  }

  Future<Response> login(String email, String password, String key) async {
    print(url);
    Encrypted enkripemail = EncryptionData().encryptData(email, key);
    Encrypted enkrippassword = EncryptionData().encryptData(password, key);
    String jwt =
        BuatJwt().Create(enkripemail.base64, enkrippassword.base64, key);

    // Codec<String, String> stringToBase64 = utf8.fuse(base64);
    // String encoded = stringToBase64
    //     .encode('${AppConstants.BasicUsername}:${AppConstants.BasicPassword}');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // "api-key": "ufr46B5waDi8dU0EgLuidOkJCrUkZQHY",
      // "Authorization": "Basic $encoded",
      "timestamps": "abc",
      "xkey": "abc",
    };
    Response response = await _dio.getUri(
        Uri.http(
            AppConstants.MainUrl, '${AppConstants.V1}${AppConstants.Login}'),
        options: Options(headers: header));

    return response;
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
}
