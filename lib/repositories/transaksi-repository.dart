import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/constant/appconstants.dart';

class TransaksiRepository {
  late Dio _dio;

  TransaksiRepository() {
    _dio = Dio();
    _dio.options.validateStatus = (int? status) {
      return status! >= 200 && status < 500;
    };
  }

  Future<dynamic> GetTransaksi() async {
    try {
      final storage.FlutterSecureStorage storages =
          storage.FlutterSecureStorage();
      var token = await storages.read(key: 'token');
      Map<String, String> header = {
        // 'Content-type': 'application/json',
        // 'Accept': 'application/json',
        'acc': token!,
        // "timestamps": "abc",
        // "xkey": "abc",
      };
      Response response = await _dio.getUri(
          Uri.http("${AppConstants.MainUrl}",
              "${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}"),
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
}
