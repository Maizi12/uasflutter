import 'package:uas_flutter/repositories/transaksi-repository.dart';

class TransaksiServices {
  Future<dynamic> getTransaksi(String page, pagesize, id) {
    // print("service");
    return TransaksiRepository().GetTransaksi(page, pagesize, id);
  }
}

final transaksiServices = TransaksiServices();
