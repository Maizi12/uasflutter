import 'package:hive_flutter/hive_flutter.dart';

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
    // print("json");
    // print(json);
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

class GetKeyModel {
  final String key;
  final String timestamppass;
  GetKeyModel({required this.key, required this.timestamppass});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "key": key,
      'timestamppass': timestamppass,
    };
  }

  factory GetKeyModel.fromMap(Map<String, dynamic> map) {
    return GetKeyModel(key: map["key"], timestamppass: map["timestamppass"]);
  }
  factory GetKeyModel.fromJson(Map<String, dynamic> json) {
    // print("json");
    // print(json);
    return GetKeyModel(
      key: json['key'],
      timestamppass: json['timestamppass'],
    );
    // data: Data.fromJson(json['data']));
  }
}

class GetTxModelDetail {
  final int idTransaksi;
  final String KeteranganTransaksi;
  String TanggalTransaksi;
  final int nominal;
  final int idCoaDebit;
  final int idCoaKredit;
  final String NamaCoaDebit;
  final String NamaCoaKredit;
  final double SaldoDebit;
  final double SaldoKredit;
  final String KodeCoaDebit;
  final String KodeCoaKredit;
  GetTxModelDetail({
    required this.idTransaksi,
    required this.KeteranganTransaksi,
    required this.TanggalTransaksi,
    required this.nominal,
    required this.idCoaDebit,
    required this.idCoaKredit,
    required this.NamaCoaKredit,
    required this.NamaCoaDebit,
    required this.SaldoKredit,
    required this.SaldoDebit,
    required this.KodeCoaKredit,
    required this.KodeCoaDebit,
  });
  factory GetTxModelDetail.empty() {
    return GetTxModelDetail(
      idTransaksi: 0,
      KeteranganTransaksi: "",
      nominal: 0,
      idCoaDebit: 0,
      idCoaKredit: 0,
      TanggalTransaksi: "",
      NamaCoaDebit: "",
      NamaCoaKredit: "",
      KodeCoaDebit: "",
      KodeCoaKredit: "",
      SaldoDebit: 0,
      SaldoKredit: 0,
    );
  }
  factory GetTxModelDetail.fromJson(Map<String, dynamic> json) {
    return GetTxModelDetail(
      idTransaksi: json["idTransaksi"],
      KeteranganTransaksi: json["KeteranganTransaksi"],
      nominal: json["nominal"],
      idCoaDebit: json["idCoaDebit"],
      idCoaKredit: json["idCoaKredit"],
      TanggalTransaksi: json["tglTransaksi"],
      NamaCoaDebit: json["namaCoaDebit"],
      NamaCoaKredit: json["namaCoaKredit"],
      KodeCoaDebit: json["kodeCoaDebit"],
      KodeCoaKredit: json["kodeCoaKredit"],
      SaldoDebit: json["saldoDebit"],
      SaldoKredit: json["saldoKredit"],
    );
  }
}

class GetTxModel {
  final int idTransaksi;
  final String KeteranganTransaksi;
  final String DebitKredit;
  // final String WaktuTransaksi;
  final String CreatedAtHour;
  final String TanggalTransaksi;
  final num sisaSaldo;
  final num nominal;
  final int idUser;
  final int idCoa;
  GetTxModel({
    required this.idTransaksi,
    required this.KeteranganTransaksi,
    required this.DebitKredit,
    required this.CreatedAtHour,
    required this.TanggalTransaksi,
    required this.nominal,
    required this.idUser,
    required this.idCoa,
    required this.sisaSaldo,
  });
  factory GetTxModel.empty() {
    return GetTxModel(
        idTransaksi: 0,
        KeteranganTransaksi: "",
        DebitKredit:"",
        CreatedAtHour: "",
        nominal: 0,
        idUser: 0,
        idCoa: 0,
        TanggalTransaksi: "",
        sisaSaldo: 0);
  }
  factory GetTxModel.fromJson(Map<String, dynamic> json) {
    return GetTxModel(
        idTransaksi: json["idTransaksi"],
        KeteranganTransaksi: json["KeteranganTransaksi"],
        DebitKredit: json["debitKredit"],
        // WaktuTransaksi: json["waktuTransaksi"],
        CreatedAtHour: json["created_at_hour"],
        nominal: json["nominal"],
        idUser: json["idUser"],
        idCoa: json["idCoa"],
        TanggalTransaksi: json["tglTransaksi"],
        sisaSaldo: json["sisaSaldo"]);
  }
}

class GetWalletModel extends HiveObject {
  @HiveField(0)
  final int idWallet;
  @HiveField(1)
  final String NamaWallet;
  @HiveField(2)
  final num TotalSaldo;
  @HiveField(3)
  final String KodeCoa;

  GetWalletModel({
    required this.idWallet,
    required this.NamaWallet,
    required this.TotalSaldo,
    required this.KodeCoa,
  });
  factory GetWalletModel.empty() {
    return GetWalletModel(
        idWallet: 0, NamaWallet: "", TotalSaldo: 0, KodeCoa: "");
  }
  factory GetWalletModel.createWallet() {
    return GetWalletModel(
        idWallet: 0, NamaWallet: "Create Wallet", TotalSaldo: 0, KodeCoa: "");
  }
  factory GetWalletModel.fromJsonWallet(Map<String, dynamic> json) {
    return GetWalletModel(
        idWallet: json["idCoa"],
        NamaWallet: json["namaCoa"],
        TotalSaldo: json["nominal"],
        KodeCoa: json["kodeCoa"]);
  }
}

// Create a TypeAdapter for GetWalletModel
class GetWalletModelAdapter extends TypeAdapter<GetWalletModel> {
  @override
  final int typeId = 0;

  @override
  GetWalletModel read(BinaryReader reader) {
    try {
      final idWallet = reader.readInt();
      final NamaWallet = reader.readString();
      final TotalSaldo = reader.readDouble();
      // KodeCoa: reader.readInt().toString(),
      // KodeCoa: reader.readString(),
      final KodeCoa = reader.readString();
      return GetWalletModel(
        idWallet: idWallet,
        NamaWallet: NamaWallet,
        TotalSaldo: TotalSaldo,
        KodeCoa: KodeCoa,
      );
    } catch (_) {
      // fallback jika data lama tidak punya 'nama'
      return GetWalletModel(
        idWallet: 0,
        NamaWallet: "",
        TotalSaldo: 0,
        KodeCoa: "",
      );
    }
  }

  @override
  void write(BinaryWriter writer, GetWalletModel obj) {
    writer.writeInt(obj.idWallet);
    writer.writeString(obj.NamaWallet);
    writer.write(obj.TotalSaldo);
    writer.writeString(obj.KodeCoa);
  }
}

class GetJenisCoaModel {
  final int idJenisCoa;
  final String NamaJenisCoa;
  GetJenisCoaModel({
    required this.idJenisCoa,
    required this.NamaJenisCoa,
  });

  factory GetJenisCoaModel.fromJson(Map<String, dynamic> json) {
    return GetJenisCoaModel(
      idJenisCoa: json["idJenisCoa"],
      NamaJenisCoa: json["namaJenisCoa"],
    );
  }
}

class GetJenisTransaksiModel {
  final int idJenisTransaksi;
  final String NamaJenisTransaksi;
  GetJenisTransaksiModel({
    required this.idJenisTransaksi,
    required this.NamaJenisTransaksi,
  });

  factory GetJenisTransaksiModel.fromJson(Map<String, dynamic> json) {
    return GetJenisTransaksiModel(
      idJenisTransaksi: json["idJenisTransaksi"],
      NamaJenisTransaksi: json["namaJenisTransaksi"],
    );
  }
}

class GetWallet {
  int? idWallet;
  String? NamaWallet;

  GetWallet({
    this.idWallet,
    this.NamaWallet,
  });
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

class GetBerandaModel {
  final num totalDebit;
  final num totalKredit;
  final num totalSisa;
  final List<TransaksiBeranda> harian;
  final List<TransaksiBeranda> pekanan;
  final List<TransaksiBeranda> bulanan;
  int isget;
  int idCoa;
  GetBerandaModel({
    required this.totalDebit,
    required this.totalKredit,
    required this.totalSisa,
    required this.harian,
    required this.pekanan,
    required this.bulanan,
    required this.isget,
    required this.idCoa,
  });
  factory GetBerandaModel.empty() {
    return GetBerandaModel(
      totalDebit: 0,
      totalKredit: 0,
      totalSisa: 0,
      isget: 0,
      idCoa: 0,
      harian: [],
      pekanan: [],
      bulanan: [],
    );
  }
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
      idCoa: json["idCoa"],
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

  factory TransaksiBeranda.fromJsonList(dynamic json) {
    return TransaksiBeranda(json["waktuTransaksi"] as String,
        json["debit"] as num, json["kredit"] as num, 0);
  }
}
