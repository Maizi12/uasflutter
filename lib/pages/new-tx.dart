import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/view/category/createCategory.dart';
import 'package:uas_flutter/domain/bloc/transaksi/transaksi_bloc.dart';
import 'package:uas_flutter/helper/rupiah.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/models/transaksi-go.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';
import 'package:uas_flutter/view/transaksi/transaksi2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTransaksiRevApp extends StatefulWidget {
  CreateTransaksiRevApp({
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
        body: SingleChildScrollView(
            child: Container(
                width: 375,
                height: 820,
                decoration: const BoxDecoration(
                  color: Color(0xffF5F7FF),
                ),
                child: Column(children: [
                  const SizedBox(
                    height: 44,
                  ),
                  SizedBox(
                    width: 375,
                    height: 40,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                            child: IconButton(
                              iconSize: 24,
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                if (context.mounted)
                                  Navigator.of(context).pop();
                              },
                            )),
                        Container(
                          margin: const EdgeInsets.fromLTRB(50, 20, 0, 0),
                          width: 125,
                          height: 24,
                          child: const Text(
                            'Buat Transaksi',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              // color: Color.fromARGB(0, 0, 0, 0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 375,
                    height: 729,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 20,
                            ),
                            Container(
                              width: 114,
                              height: 44,
                              child: Column(
                                children: [
                                  Container(
                                    width: 89,
                                    height: 19,
                                    child: Text("Nama Transaksi"),
                                  ),
                                  Container(
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
                            Container(
                              width: 77,
                              height: 44,
                              child: Column(
                                children: [
                                  Container(
                                    width: 64,
                                    height: 15,
                                    child: const Text("Nama Coa"),
                                  ),
                                  Container(
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
                            Container(
                              width: 69,
                              height: 43,
                              child: Column(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 13,
                                    child: const Text("Pilih Akun"),
                                  ),
                                  Container(
                                      width: 77,
                                      height: 21,
                                      child: Text("nama Akun")),
                                  Container(
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
