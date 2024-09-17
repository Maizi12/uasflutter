import 'dart:convert';

import 'package:uas_flutter/createCategory.dart';
import 'package:uas_flutter/models/daysmodel/daysmodel.dart';
import 'package:uas_flutter/models/monthmodel/monthmodel.dart';
import 'package:uas_flutter/models/weekmodel/weekmodel.dart';

class MetaModel {
  final String message;
  final String code;
  final dynamic data;
  String? key;
  MetaModel({required this.message, required this.data, required this.code});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "message": message,
      "data": data,
    };
  }

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    return MetaModel(
        message: map["message"], data: map["data"], code: map["code"]);
  }
  factory MetaModel.fromJson(Map<String, dynamic> json) {
    print("json");
    print(json);
    return MetaModel(
      message: json['responseMessage'],
      code: json['responseCode'],
      data: json['data'],
    );
    // data: Data.fromJson(json['data']));
  }
  // String toJson() => json.encode(toMap());

  // factory MetaModel.fromJson(String source)=>MetaModel.fromMap(json.decode(source) as Map<String,dynamic>)
}

class GetTransaksi {
  // String idTransaksi;
  // String KeteranganTransaksi;
  // String idJenisTransaksi;
  // String nominal;
  // String idUser;
  // String idWallet;
  final GetTxModel data;
  // String? key;
  GetTransaksi({
    //   // this.idTransaksi,
    required this.data,
    //   // this.KeteranganTransaksi,
    //   // this.idJenisTransaksi,
    //   // this.nominal,
    //   // this.idUser,
    //   // this.idWallet,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     "idTransaksi": idTransaksi,
  //     "data": data,
  //   };
  // }

  factory GetTransaksi.fromJson(Map<String, dynamic> jsondata) {
    print("jsondata gettx");
    print(jsondata['data']);
    print((jsondata['data']));
    List<dynamic> jsonarray = ((jsondata['data']));
    // List<dynamic> jsonarray = (json.decode(jsondata['data']));
    print("jsonarray");
    print(jsonarray[0]);
    return GetTransaksi(
      data: GetTxModel.fromJson(jsonarray[0]),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory GetTransaksi.fromJson(String source) =>
  //     GetTransaksi.fromMap(json.decode(source) as Map<String, dynamic>);
}

class GetTxModel {
  final int idTransaksi;
  final String KeteranganTransaksi;
  final String DebitKredit;
  final int idJenisTransaksi;
  final int nominal;
  final int idUser;
  final int idWallet;
  GetTxModel({
    required this.idTransaksi,
    required this.KeteranganTransaksi,
    required this.DebitKredit,
    required this.idJenisTransaksi,
    required this.nominal,
    required this.idUser,
    required this.idWallet,
  });
  factory GetTxModel.fromJson(Map<String, dynamic> json) {
    print("gettxmodel json");
    print(json);
    print(json["idTransaksi"]);
    return GetTxModel(
      idTransaksi: json["idTransaksi"],
      KeteranganTransaksi: json["KeteranganTransaksi"],
      idJenisTransaksi: json["idJenisTransaksi"],
      DebitKredit: json["debitKredit"],
      nominal: json["nominal"],
      idUser: json["idUser"],
      idWallet: json["idWallet"],
    );
    // data: Data.fromJson(json['data']));
  }
}

class GetWalletModel {
  final int idWallet;
  final String NamaWallet;
  final int TotalSaldo;
  GetWalletModel({
    required this.idWallet,
    required this.NamaWallet,
    required this.TotalSaldo,
  });

  // factory GetWalletModel.fromJson(Map<String, dynamic> jsons) {
  //   Iterable jsonarray = (jsons['data']);
  //   List<GetWalletModel> getwallet = List<GetWalletModel>.from(jsonarray.map(
  //       (model) => GetWalletModel(
  //           idWallet: model["idWallet"], NamaWallet: model["namaWallet"])));
  //   // return getwallet;
  // }
}

class GetJenisTransaksiModel {
  final int idJenisTransaksi;
  final String NamaJenisTransaksi;
  GetJenisTransaksiModel({
    required this.idJenisTransaksi,
    required this.NamaJenisTransaksi,
  });

  // factory GetWalletModel.fromJson(Map<String, dynamic> jsons) {
  //   Iterable jsonarray = (jsons['data']);
  //   List<GetWalletModel> getwallet = List<GetWalletModel>.from(jsonarray.map(
  //       (model) => GetWalletModel(
  //           idWallet: model["idWallet"], NamaWallet: model["namaWallet"])));
  //   // return getwallet;
  // }
}

class GetWallet {
  int? idWallet;
  String? NamaWallet;

  GetWallet({
    this.idWallet,
    this.NamaWallet,
  });
}

// List<dynamic> jsonarray = ((jsondata['data']));
//     print("jsonarray");
//     print(jsonarray[0]);
//     return GetTransaksi(
//       data: GetTxModel.fromJson(jsonarray[0]),
//     );
class Data {
  String token;
  String UserName;
  Data({required this.token, required this.UserName});
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(token: json['access_token'], UserName: json['userName']);
  }
}

class MetaModelData {
  final String Key;

  MetaModelData({required this.Key});
  factory MetaModelData.fromMap(Map<String, dynamic> map) {
    return MetaModelData(Key: map["key"]);
  }
}

class GetBerandaModel {
  final num totalDebit;
  final num totalKredit;
  final num totalSisa;
  final List<TransaksiBeranda> harian;
  final List<TransaksiBeranda> pekanan;
  final List<TransaksiBeranda> bulanan;
  int isget;
  int idWallet;
  GetBerandaModel({
    required this.totalDebit,
    required this.totalKredit,
    required this.totalSisa,
    required this.harian,
    required this.pekanan,
    required this.bulanan,
    required this.isget,
    required this.idWallet,
  });
  factory GetBerandaModel.fromJson(Map<String, dynamic> json) {
    var listHarian = json["harian"] as List;
    List<TransaksiBeranda> berandaHarian = listHarian
        .map((harian) => TransaksiBeranda.fromJsonList(harian))
        .toList();
    var listPekanan = json["pekanan"] as List;
    List<TransaksiBeranda> berandaPekanan = listPekanan
        .map((pekanan) => TransaksiBeranda.fromJsonList(pekanan))
        .toList();
    var listBulanan = json["bulanan"] as List;
    List<TransaksiBeranda> berandaBulanan = listBulanan
        .map((pekanan) => TransaksiBeranda.fromJsonList(pekanan))
        .toList();
    print("berandaPekanan.last");
    print(berandaPekanan.length);
    print("berandaBulanan.last");
    print(berandaBulanan.last);
    return GetBerandaModel(
      totalDebit: json["totalDebit"],
      totalKredit: json["totalKredit"],
      totalSisa: json["totalSisa"],
      harian: berandaHarian,
      pekanan: berandaPekanan,
      bulanan: berandaBulanan,
      isget: 1,
      idWallet: json["idWallet"],
    );
    // data: Data.fromJson(json['data']));
  }
}

class TransaksiBeranda {
  String WaktuTransaksi;
  num Debit;
  num Kredit;
  int Used;
  TransaksiBeranda(
    this.WaktuTransaksi,
    this.Debit,
    this.Kredit,
    this.Used,
  );
  // factory TransaksiBeranda.fromJson(Map<String, dynamic> json) {
  //   return TransaksiBeranda(
  //     WaktuTransaksi: json["waktuTransaksi"],
  //     Debit: json["debit"],
  //     Kredit: json["kredit"],
  //   );
  // }
  factory TransaksiBeranda.fromJsonList(dynamic json) {
    print("json");
    print(json);
    return TransaksiBeranda(json["waktuTransaksi"] as String,
        json["debit"] as num, json["kredit"] as num, 0);
  }
}
