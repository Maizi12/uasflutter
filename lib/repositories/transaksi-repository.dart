import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/constant/appconstants.dart';
import 'package:uas_flutter/repositories/golang-repository.dart';

class TransaksiRepository {
  late Dio _dio;

  TransaksiRepository() {
    _dio = Dio();
    _dio.options.validateStatus = (int? status) {
      return status! >= 200 && status < 500;
    };
  }

  Future<dynamic> GetTransaksi(String page, pagesize, id) async {
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
        // 'Content-type': 'application/json',
        // 'Accept': 'application/json',
        'acc': tokens,
        // "timestamps": "abc",
        // "xkey": "abc",
      };
      print("getTransaksi");
      print("header");
      print(header);
      print(
          "${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}?page=$page&pagesize=$pagesize&id=$id");
      Response response = await _dio.getUri(
          Uri.http(
              "${AppConstants.MainUrl}",
              "${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}",
              {'page': page, 'pagesize': pagesize, 'id': id}),
          options: Options(headers: header));
      print("response");
      print(response);
      print(response.realUri);
      print("response.data");
      print(response.data);
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

Future<List<GetTxModel>> GetTxData(String page, pagesize, id) {
  return TransaksiRepository().GetTransaksi("1", "10", "").then((jsonlist) {
    var responjson = json.decode(jsonlist.toString());
    Iterable jsonarray = (responjson['data']);
    List<GetTxModel> gettxs =
        List<GetTxModel>.from(jsonarray.map((model) => GetTxModel(
              idTransaksi: model["idTransaksi"],
              KeteranganTransaksi: model["KeteranganTransaksi"],
              idJenisTransaksi: model["idJenisTransaksi"],
              nominal: model["nominal"],
              idUser: model["idUser"],
              idWallet: model["idWallet"],
            )));
    return gettxs;
  }, onError: (e) => print("error completing $e"));
}

Future<List<GetWalletModel>> GetWalletData(String page, pagesize, id) {
  return UserRepository().GetWallet().then((jsonlist) {
    var responjson = json.decode(jsonlist.toString());
    Iterable jsonarray = (responjson['data']);
    print("responjson['data']");
    print(responjson['data']);
    List<GetWalletModel> getwallet = List<GetWalletModel>.from(jsonarray.map(
        (model) => GetWalletModel(
            idWallet: model["idWallet"],
            NamaWallet: model["namaWallet"],
            TotalSaldo: model["totalSaldo"])));
    return getwallet;
  }, onError: (e) => print("error completing $e"));
}
