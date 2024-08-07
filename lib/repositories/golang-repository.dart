import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
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
  late Dio _dio;
  final storage.FlutterSecureStorage storages = storage.FlutterSecureStorage();
  UserRepository() {
    _dio = Dio();
    _dio.options.validateStatus = (int? status) {
      return status! >= 200 && status < 500;
    };
  }

  Future<void> storeToken(String token) async {
    // final encryptedToken = hash.encrypt(token);
    print('ini enkripsi token: $token');
    await storages.write(key: 'token', value: token);
    // await storages.write(key: 'userName', value: username);
  }

  late ResponseEnkrip getkey;

  String url =
      '${AppConstants.API}${AppConstants.DigitEnkrip}${AppConstants.V1}${AppConstants.User}${AppConstants.Enkrip}';

  Future<dynamic> GetKey() async {
    try {
      // print(url);
      print("getkey");
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
          Uri.http("${AppConstants.MainUrl}",
              "${AppConstants.API}${AppConstants.DigitEnkrip}${AppConstants.V1}${AppConstants.User}${AppConstants.Enkrip}"),
          options: Options(headers: header));
      print("response");
      print(response);
      return response.data;
    } on DioException catch (e) {
      print("failed catch");
      return MetaModel(message: e.toString(), code: "201", data: null);
    } catch (e) {
      print("failed");

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

  Future<dynamic> login(String email, String password) async {
    // print(url);
    final enkrips = await GetKey();
    print("enkrips");
    print("email");
    print(email);
    print("email");
    print(password);
    print(enkrips);
    try {
      MetaModel metas = MetaModel.fromJson(enkrips);
    } catch (e) {
      print("error from Map $e");
    }
    MetaModel metas = MetaModel.fromJson(enkrips);
    MetaModelData meta = MetaModelData.fromMap(metas.data);
    String keys = meta.Key;
    print("keys");
    print(keys);
    Encrypted enkripemail =
        EncryptionData().encryptData(email, keys + AppConstants.GoKeyAES);
    Encrypted enkrippassword =
        EncryptionData().encryptData(password, keys + AppConstants.GoKeyAES);
    String jwt = BuatJwt().Create(enkripemail.base64, enkrippassword.base64,
        keys + AppConstants.GoKeyAES);
    print("jwt");
    print(jwt);
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'key': keys + AppConstants.GoKeyAES,
      'acc': jwt,
      "timestamps": "abc",
      "xkey": "abc",
    };
    Response response = await _dio.postUri(
        Uri.http(AppConstants.MainUrl,
            '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Login}'),
        options: Options(headers: header));

    return response.data;
  }

  Future<dynamic> GetWallet() async {
    try {
      final storage.FlutterSecureStorage storages =
          storage.FlutterSecureStorage();
      var token = await storages.read(key: 'token');
      String tokens;
      if (token == null) {
        return;
      } else {
        tokens = token;
      }
      Map<String, String> header = {
        'acc': tokens,
      };
      Response response = await _dio.getUri(
          Uri.http(AppConstants.MainUrl,
              '${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.Wallet}'),
          options: Options(headers: header));
      return response;
    } on DioException catch (e) {
      print("failed catch");
      print("e");
      print(e.toString());
      if (e.toString().contains("500")) {
        return "500";
      }
      return MetaModel(message: e.toString(), code: "201", data: null);
    } catch (e) {
      print("failed");
      print("e");
      print(e.toString());
      return MetaModel(message: e.toString(), code: "201", data: null);
    }
  }

  Future<dynamic> GetJenisTransaksi(String id) async {
    try {
      final storage.FlutterSecureStorage storages =
          storage.FlutterSecureStorage();
      var token = await storages.read(key: 'token');
      String tokens;
      if (token == null) {
        return;
      } else {
        tokens = token;
      }
      Map<String, String> header = {
        'acc': tokens,
      };
      Response response = await _dio.getUri(
          Uri.http(
              AppConstants.MainUrl,
              '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.JenisTransaksi}',
              {'idJenisTransaksi': id}),
          options: Options(headers: header));
      print("response");
      print(response);
      return response;
    } on DioException catch (e) {
      print("failed catch");
      print("e");
      print(e.toString());
      if (e.toString().contains("500")) {
        return "500";
      }
      return MetaModel(message: e.toString(), code: "201", data: null);
    } catch (e) {
      print("failed");
      print("e");
      print(e.toString());
      return MetaModel(message: e.toString(), code: "201", data: null);
    }
  }
}
