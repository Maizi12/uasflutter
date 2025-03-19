class NewTxCard {
  int idTx;
  String namaTransaksiBarang;
  String tanggalTransaksi;
  String akunDebit;
  String akunKredit;
  int qty;
  double hargaSatuan;
  double biayaTambahan;
  double nominalTransaksi;
  NewTxCard({
    required this.idTx,
    required this.namaTransaksiBarang,
    required this.tanggalTransaksi,
    required this.akunDebit,
    required this.akunKredit,
    required this.qty,
    required this.hargaSatuan,
    required this.biayaTambahan,
    required this.nominalTransaksi,
  });
}
