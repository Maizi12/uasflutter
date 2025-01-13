import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
import 'package:uas_flutter/domain/services/hive/hive.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/constant/appconstants.dart';
import 'package:uas_flutter/models/transaksi-go.dart';
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
      print(page);
      print(pagesize);
      print(
          "${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}?page=$page&pagesize=$pagesize&idTransaksi=$id");
      Response response = await _dio.getUri(
          Uri.http(
              AppConstants.MainUrl,
              "${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}",
              {'page': page, 'pagesize': pagesize, 'idTransaksi': id}),
          options: Options(headers: header));
      print("response tx");
      print(response);
      print(response.realUri);
      print("responsetx.data");
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

  Future<MetaModel> CreateTransaksi(TransaksiGo Transaksi) async {
    try {
      final storage.FlutterSecureStorage storages =
          storage.FlutterSecureStorage();
      var token = await storages.read(key: 'token');
      token ??= ""; 
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'acc': token,
      };

      var datas = json.encode(TransaksiGo.toJSON(Transaksi));
      print("datas");
      print(datas);
      Response response = await _dio.postUri(
          Uri.http(AppConstants.MainUrl,
              '${AppConstants.API}${AppConstants.DigitTransaksi}${AppConstants.V1}${AppConstants.Transaksi}${AppConstants.Transaksi}'),
          options: Options(headers: header),
          data: datas);
      print(response);
      print(MetaModel.fromJson(response.data));
      return MetaModel.fromJson(response.data);
      // return response.data;
    } on DioException catch (e) {
      print("failed catch");
      print("e");
      print(e.toString());
      if (e.toString().contains("500")) {
        return MetaModel(message: "failed", code: "500", data: null);
      }
      return MetaModel(message: e.toString(), code: "201", data: null);
    } catch (e) {
      print("failed");
      print("e");
      print(e.toString());
      return MetaModel(message: e.toString(), code: "201", data: null);
    }
  }

  Future<dynamic> GetBeranda(int idWallet) async {
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

      print(
          "${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.Beranda}");
      Response response = await _dio.getUri(
          Uri.http(
              AppConstants.MainUrl,
              "${AppConstants.API}${AppConstants.DigitUser}${AppConstants.V1}${AppConstants.Master}${AppConstants.Beranda}",
              {
                'idWallet': "$idWallet",
              }),
          options: Options(headers: header));
      print("response tx beranda");
      print("$response beranda");
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
  TransaksiRepository().GetTransaksi("1", "10", id);
  return TransaksiRepository().GetTransaksi("1", "10", id).then((jsonlist) {
    var responjson = json.decode(jsonlist.toString());
    Iterable jsonarray = (responjson['data']);
    List<GetTxModel> gettxs =
        List<GetTxModel>.from(jsonarray.map((model) => GetTxModel(
              idTransaksi: model["idTransaksi"],
              KeteranganTransaksi: model["KeteranganTransaksi"],
              idJenisTransaksi: model["idJenisTransaksi"],
              DebitKredit: model["debitKredit"],
              WaktuTransaksi: model["waktuTransaksi"],
              nominal: model["nominal"],
              idUser: model["idUser"],
              idWallet: model["idWallet"],
            )));
    return gettxs;
  }, onError: (e) => print("error completing $e"));
}

Future<GetTxModel> GetTxOne(String page, pagesize, id) {
  return TransaksiRepository().GetTransaksi("", "", id).then((jsonlist) {
    var responjson = json.decode(jsonlist.toString());
    print("gettxone json");
    print(responjson['data']);
    // Iterable jsonarray = (responjson['data']);
    print(responjson['data']);
    GetTxModel gettxs = GetTxModel.fromJson(responjson['data']);
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

List<GetWalletModel> GetWalletDataStorage() {
  var jsonlist = BoxMixin().getData(KeyStorage.keyWallet);
  if (jsonlist == null) {}
  print("jsonlist");
  print(jsonlist);
  // var getwallet = jsonlist as List<GetWalletModel>;
  List<GetWalletModel> walletList = jsonlist.cast<GetWalletModel>();
  return walletList;
  // var responjson = json.decode(jsonlist.toString());
  // Iterable jsonarray = (responjson['data']);
  // print("responjson['data']");
  // print(responjson['data']);
  // List<GetWalletModel> getwallet = List<GetWalletModel>.from(jsonlist((model) =>
  //     GetWalletModel(
  //         idWallet: model["idWallet"],
  //         NamaWallet: model["namaWallet"],
  //         TotalSaldo: model["totalSaldo"])));
  // return getwallet;
  // List<GetWalletModel> getwall = [
  //   GetWalletModel(
  //     idWallet: 0,
  //     NamaWallet: '',
  //     TotalSaldo: 1,
  //   ),
  // ];
  // return getwall;
}

Future<List<GetJenisTransaksiModel>> GetJenisTransaksiData(String id) {
  return UserRepository().GetJenisTransaksi(id).then((jsonlist) {
    var responjson = json.decode(jsonlist.toString());
    Iterable jsonarray = (responjson['data']);
    print("responjson['data']");
    print(responjson['data']);
    List<GetJenisTransaksiModel> getwallet = List<GetJenisTransaksiModel>.from(
        jsonarray.map((model) => GetJenisTransaksiModel(
              idJenisTransaksi: model["idJenisTransaksi"],
              NamaJenisTransaksi: model["namaJenisTransaksi"],
            )));
    return getwallet;
  }, onError: (e) => print("error completing $e"));
}

Future<GetBerandaModel> GetBerandaData(int idWallet) {
  TransaksiRepository().GetBeranda(idWallet);
  return TransaksiRepository().GetBeranda(idWallet).then((jsonlist) {
    print("jsonlist.toString()");
    print(jsonlist.toString());
    var responjson = json.decode(jsonlist.toString());
    print("GetBerandata");
    print(responjson['data']);
    print(responjson['data']);
    GetBerandaModel gettxs = GetBerandaModel.fromJson(responjson['data']);
    return gettxs;
  }, onError: (e) => print("error completing $e"));
}



Future<GetBerandaModel> GetBerandaDataStorage() {
   var jsonlist = BoxMixin().getData(KeyStorage.getBeranda);
  return jsonlist.cast<GetBerandaModel>();
}

