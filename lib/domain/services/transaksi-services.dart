import 'package:uas_flutter/repositories/transaksi-repository.dart';

class TransaksiServices {
  Future<dynamic> getTransaksi() {
    // print("service");
    return TransaksiRepository().GetTransaksi();
  }
}

final transaksiServices = TransaksiServices();
