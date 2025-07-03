class TransaksiGo {
  int idTransaksi;
  String keteranganTransaksi;
  double nominal;
  String tglTransaksi;
  int idUser;
  int idCoaDebit;
  int idCoaKredit;
  TransaksiGo({
    required this.idTransaksi,
    required this.keteranganTransaksi,
    required this.nominal,
    required this.tglTransaksi,
    required this.idUser,
    required this.idCoaDebit,
    required this.idCoaKredit,
  });

  Map<String, dynamic> toJSON(TransaksiGo transaksi) => {
        'idTransaksi': transaksi.idTransaksi,
        'keteranganTransaksi': transaksi.keteranganTransaksi,
        'tglTransaksi': transaksi.tglTransaksi,
        'nominal': transaksi.nominal,
        'idUser': transaksi.idUser,
        'idCoaDebit': transaksi.idCoaDebit,
        'idCoaKredit': transaksi.idCoaKredit,
      };
  Map<String, dynamic> WrapRequest(dynamic data) => {
        'transaksi': data,
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
