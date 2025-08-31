import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/pages/components/header.dart';

class CreateTransaksiRevApp extends StatefulWidget {
  const CreateTransaksiRevApp({
    super.key,
  });
  // List<GetWalletModel>? listWallet;
  // GetWalletModel? selectedwallet;
  // String? dropdownWalletValue;
  // List<GetJenisTransaksiModel>? listJenisTransaksi;
  // GetJenisTransaksiModel? selectedjenisTransaksi;
  // final String? restorationId;
  // String tanggal = "";
  // String? dropdownJenisTransaksiValue;
  // final RestorableDateTime _selectedDate = RestorableDateTime(
  //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  @override
  State<CreateTransaksiRevApp> createState() => CreateTransaksiRev();
}

class CreateTransaksiRev extends State<CreateTransaksiRevApp> {
  TextEditingController namaTransaksiController = TextEditingController();
  TextEditingController namaCoaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderCard(namaMenu: "Buat Transaksi"),
        body: SingleChildScrollView(
            child: Container(
                width: 375,
                height: 820,
                decoration: const BoxDecoration(
                  color: Color(0xffF5F7FF),
                ),
                child: Column(children: [
                  SizedBox(
                    width: 375,
                    height: 729,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 20,
                            ),
                            SizedBox(
                              width: 114,
                              height: 44,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 89,
                                    height: 19,
                                    child: Text("Nama Transaksi"),
                                  ),
                                  SizedBox(
                                    width: 114,
                                    height: 21,
                                    child: TextField(
                                      controller: namaTransaksiController,
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        labelText: 'Nama Transaksi',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            SizedBox(
                              width: 77,
                              height: 44,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 64,
                                    height: 15,
                                    child: const Text("Nama Coa"),
                                  ),
                                  SizedBox(
                                    width: 77,
                                    height: 21,
                                    child: TextField(
                                      controller: namaCoaController,
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        labelText: 'Nama Coa',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SvgPicture.asset(
                                  'assets/Calendar.svg',
                                  width: 18,
                                  height: 20,
                                )),
                            const SizedBox(
                              width: 3,
                            ),
                            SizedBox(
                              width: 69,
                              height: 43,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 45,
                                    height: 13,
                                    child: const Text("Pilih Akun"),
                                  ),
                                  SizedBox(
                                      width: 77,
                                      height: 21,
                                      child: Text("nama Akun")),
                                  SizedBox(
                                      width: 77,
                                      height: 21,
                                      child: Text("Nominal Saldo"))
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ]))));
  }
}
