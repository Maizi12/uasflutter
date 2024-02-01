import 'package:cloud_firestore/cloud_firestore.dart';

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
