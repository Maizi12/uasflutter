import 'dart:async';
import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:dio/dio.dart';

import 'package:digit/core/utils/constant/appconstants.dart';
import 'package:digit/domain/services/hive/hive.dart';
import 'package:digit/data/models/response-go.dart';
import 'package:digit/core/utils/constant/constant.dart';
import 'package:digit/core/utils/constant/jwt.dart';

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
  UserRepository() {
    _dio = Dio();
    _dio.options.validateStatus = (int? status) {
      return status! >= 200 && status < 500;
    };
  }

  late ResponseEnkrip getkey;

  String url =
      '${AppConstants.API}${AppConstants.DigitEnkrip}${AppConstants.V1}${AppConstants.User}${AppConstants.Enkrip}';

  Future<dynamic> GetKey() async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64
        .encode('${AppConstants.BasicUsername}:${AppConstants.BasicPassword}');
    Map<String, String> header = {
      "api-key": "ufr46B5waDi8dU0EgLuidOkJCrUkZQHY",
      "Authorization": "Basic $encoded",
      "timestamps": "abc",
      "xkey": "abc",
    };
    return header;
  }

  ResponseEnkrip key() {
    getkey.ResponseCode = "";
    return getkey;
  }

  Future<Map<String, String>> login(String email, String password) async {
    final enkrips = BoxMixin().getData(KeyStorage.enkripKey);
    Map<String, dynamic> enkripsmap = enkrips.cast<String, dynamic>();
    GetKeyModel metas;
    try {
      metas = GetKeyModel.fromJson(enkripsmap);
    } catch (e) {
      print("error from Map $e");
    }
    metas = GetKeyModel.fromJson(enkripsmap);
    String keys = metas.key;
    Encrypted enkripemail =
        EncryptionData().encryptData(email, keys + AppConstants.GoKeyAES);
    Encrypted enkrippassword =
        EncryptionData().encryptData(password, keys + AppConstants.GoKeyAES);
    String jwt = BuatJwt().Create(enkripemail.base64, enkrippassword.base64,
        keys + AppConstants.GoKeyAES);
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'key': keys + AppConstants.GoKeyAES,
      'acc': jwt,
      "timestamps": "abc",
      "xkey": "abc",
    };

    return header;
  }

  Future<dynamic> GetWallet() async {
    try {
      // final storage.FlutterSecureStorage storages =
      //     storage.FlutterSecureStorage();
      var token = BoxMixin().getData(KeyStorage.accessToken);
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
      // final storage.FlutterSecureStorage storages =
      //     storage.FlutterSecureStorage();
      var token = BoxMixin().getData(KeyStorage.accessToken);
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
