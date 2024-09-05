import 'dart:convert';

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
  final int idJenisTransaksi;
  final int nominal;
  final int idUser;
  final int idWallet;
  GetTxModel({
    required this.idTransaksi,
    required this.KeteranganTransaksi,
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
  final num totalPemasukan;
  final num totalPengeluaran;
  final num totalSisa;
  Sunday sunday;
  Monday monday;
  Tuesday tuesday;
  Wednesday wednesday;
  Thursday thursday;
  Friday friday;
  Saturday saturday;
  Week1 week1;
  Week2 week2;
  Week3 week3;
  Week4 week4;
  Week5 week5;
  Januari jan;
  Februari feb;
  Maret mar;
  April apr;
  Mei mei;
  Juni jun;
  Juli jul;
  Agustus agu;
  September sep;
  Oktober okt;
  November nov;
  Desember des;
  GetBerandaModel({
    required this.totalPemasukan,
    required this.totalPengeluaran,
    required this.totalSisa,
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.week1,
    required this.week2,
    required this.week3,
    required this.week4,
    required this.week5,
    required this.jan,
    required this.feb,
    required this.mar,
    required this.apr,
    required this.mei,
    required this.jun,
    required this.jul,
    required this.agu,
    required this.sep,
    required this.okt,
    required this.nov,
    required this.des,
  });
  factory GetBerandaModel.fromJson(Map<String, dynamic> json) {
    print("gettxmodel json");
    print(json);
    print(json["idTransaksi"]);
    return GetBerandaModel(
      totalPemasukan: json["totalPemasukan"],
      totalPengeluaran: json["totalPengeluaran"],
      totalSisa: json["totalSisa"],
      sunday: Sunday.fromJson(json["sunday"]),
      monday: Monday.fromJson(json["monday"]),
      tuesday: Tuesday.fromJson(json["tuesday"]),
      wednesday: Wednesday.fromJson(json["wednesday"]),
      thursday: Thursday.fromJson(json["thursday"]),
      friday: Friday.fromJson(json["friday"]),
      saturday: Saturday.fromJson(json["saturday"]),
      week1: Week1.fromJson(json["week1"]),
      week2: Week2.fromJson(json["week2"]),
      week3: Week3.fromJson(json["week3"]),
      week4: Week4.fromJson(json["week4"]),
      week5: Week5.fromJson(json["week5"]),
      jan: Januari.fromJson(json["januari"]),
      feb: Februari.fromJson(json["februari"]),
      mar: Maret.fromJson(json["maret"]),
      apr: April.fromJson(json["april"]),
      mei: Mei.fromJson(json["mei"]),
      jun: Juni.fromJson(json["juni"]),
      jul: Juli.fromJson(json["juli"]),
      agu: Agustus.fromJson(json["agustus"]),
      sep: September.fromJson(json["september"]),
      okt: Oktober.fromJson(json["oktober"]),
      nov: November.fromJson(json["november"]),
      des: Desember.fromJson(json["desember"]),
    );
    // data: Data.fromJson(json['data']));
  }
}
