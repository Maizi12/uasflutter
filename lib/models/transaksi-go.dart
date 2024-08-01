import 'dart:convert';

class TransaksiGo {
  int idTransaksi;
  String keteranganTransaksi;
  int idJenisTransaksi;
  double nominal;
  int idUser;
  int idWallet;
  TransaksiGo({
    required this.idTransaksi,
    required this.keteranganTransaksi,
    required this.idJenisTransaksi,
    required this.nominal,
    required this.idUser,
    required this.idWallet,
  });

  static Map<String, dynamic> toJSON(TransaksiGo transaksi) => {
        'idTransaksi': transaksi.idTransaksi,
        'keteranganTransaksi': transaksi.keteranganTransaksi,
        'idJenisTransaksi': transaksi.idJenisTransaksi,
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
