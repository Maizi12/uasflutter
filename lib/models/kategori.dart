import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_flutter/models/coa.dart';
import 'package:uas_flutter/models/response-go.dart';

class KategoriTransaksis {
  String namaKategori;
  int idUser;
  int idKategoriTransaksi;

  KategoriTransaksis(
      {required this.namaKategori,
      required this.idUser,
      required this.idKategoriTransaksi});

  factory KategoriTransaksis.fromDocument(DocumentSnapshot document) {
    return KategoriTransaksis(
        namaKategori: document['namaKategori'],
        idUser: document['idUser'],
        idKategoriTransaksi: document['idKategoriTransaksi']);
  }
}

class GetCategoriesModel {
  final int idJenisCoa;
  final String kodeJenisCoa;
  final String namaJenisCoa;
  GetCategoriesModel({
    required this.idJenisCoa,
    required this.kodeJenisCoa,
    required this.namaJenisCoa,
  });
  factory GetCategoriesModel.fromJson(Map<String, dynamic> json) {
    return GetCategoriesModel(
      idJenisCoa: json["idJenisCoa"],
      kodeJenisCoa: json["kodeJenisCoa"],
      namaJenisCoa: json["namaJenisCoa"],
    );
  }
}

class GetCategoriesAndSubModel {
  int idJenisCoa;
  String kodeJenisCoa;
  String namaJenisCoa;
  List<GetCoaModel> ListCoa;
  GetCategoriesAndSubModel({
    required this.idJenisCoa,
    required this.kodeJenisCoa,
    required this.namaJenisCoa,
    required this.ListCoa,
  });
}
