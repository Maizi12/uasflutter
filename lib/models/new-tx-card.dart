class NewTxCard {
  int idTx;
  String namaTransaksiBarang;
  String tanggalTransaksi;
  String akunDebit;
  String akunKredit;
  int idCoaDebit;
  int idCoaKredit;
  String debitKredit;

  int qty;
  double hargaSatuan;
  double biayaTambahan;
  double nominalTransaksi;
  NewTxCard(
      {required this.idTx,
      required this.namaTransaksiBarang,
      required this.tanggalTransaksi,
      required this.akunDebit,
      required this.akunKredit,
      required this.idCoaDebit,
      required this.idCoaKredit,
      required this.qty,
      required this.hargaSatuan,
      required this.biayaTambahan,
      required this.nominalTransaksi,
      required this.debitKredit});
}
