import 'dart:convert';

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
