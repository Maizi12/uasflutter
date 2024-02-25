import 'package:cloud_firestore/cloud_firestore.dart';

class Transaksis {
  String keteranganTransaksi;
  int idUser;
  int idTransaksi;
  int idKategoriTransaksi;
  int nominal;
  String WaktuTransaksi;

  Transaksis({
    required this.keteranganTransaksi,
    required this.idUser,
    required this.idTransaksi,
    required this.nominal,
    required this.idKategoriTransaksi,
    required this.WaktuTransaksi,
  });

  factory Transaksis.fromDocument(DocumentSnapshot document) {
    return Transaksis(
      keteranganTransaksi: document['keteranganTransaksi'],
      idUser: document['idUser'],
      idTransaksi: document['idTransaksi'],
      idKategoriTransaksi: document['idKategoriTransaksi'],
      nominal: document['nominal'],
      WaktuTransaksi: document['created_at'].toString(),
    );
  }
}
