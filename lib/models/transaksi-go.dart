import 'dart:convert';

class TransaksiGo {
  int idTransaksi;
  String keteranganTransaksi;
  int idJenisTransaksi;
  double nominal;
  String waktuTransaksi;
  String tglTransaksi;
  int idUser;
  int idWallet;
  TransaksiGo({
    required this.idTransaksi,
    required this.keteranganTransaksi,
    required this.idJenisTransaksi,
    required this.nominal,
    required this.waktuTransaksi,
    required this.tglTransaksi,
    required this.idUser,
    required this.idWallet,
  });

  static Map<String, dynamic> toJSON(TransaksiGo transaksi) => {
        'idTransaksi': transaksi.idTransaksi,
        'keteranganTransaksi': transaksi.keteranganTransaksi,
        'idJenisTransaksi': transaksi.idJenisTransaksi,
        'waktuTransaksi': transaksi.waktuTransaksi,
        'tglTransaksi': transaksi.tglTransaksi,
        'nominal': transaksi.nominal,
        'idUser': transaksi.idUser,
        'idWallet': transaksi.idWallet
      };
  // return TransaksiGo(
  //   idTransaksi: transaksi.idTransaksi,
  //   keteranganTransaksi: transaksi.keteranganTransaksi,
  //   idJenisTransaksi: transaksi.idJenisTransaksi,
  //   nominal: transaksi.nominal,
  //   idUser: transaksi.idUser,
  //   idWallet: transaksi.idWallet,
  // );
}
