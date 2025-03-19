import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/models/new-tx-card.dart';
import 'package:uas_flutter/pages/header.dart';
import 'package:uas_flutter/pages/new-tx-card.dart';

class CreateMultiTransaksiApp extends StatefulWidget {
  const CreateMultiTransaksiApp({
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
  State<CreateMultiTransaksiApp> createState() => CreateMultiTransaksi();
}

class CreateMultiTransaksi extends State<CreateMultiTransaksiApp> {
  List<NewTxCard> data = [
    NewTxCard(
        idTx: 0,
        namaTransaksiBarang: "",
        tanggalTransaksi: "",
        akunDebit: "",
        akunKredit: "",
        qty: 0,
        hargaSatuan: 0,
        biayaTambahan: 0,
        nominalTransaksi: 0)
  ];
  TextEditingController namaTransaksiController = TextEditingController();
  TextEditingController namaCoaController = TextEditingController();
  int totalItem = 0;
  double totalTransaksi = 0;
  double biayaTambahan = 0;
  double totalTransaksiAll = 0;
  String tanggal = "";
  final DateTime now = DateTime.now();

  int itemCounts = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderCard(namaMenu: "Buat Transaksi"),
        body: Container(
          width: 375,
          height: 820,
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: 375,
                  height: 508,
                  decoration: const BoxDecoration(
                    color: Color(0xffF5F7FF),
                  ),
                  child: Column(
                    children: [
                      Container(
                          width: 375,
                          height: 425,
                          child: ListView.builder(
                            itemCount: itemCounts,
                            itemBuilder: (BuildContext context, int index) {
                              return CreateNewTxCardApp(
                                onremove: () {
                                  setState(() {
                                    data.removeAt(index);
                                    itemCounts--;
                                  });
                                },
                                onupdate: () {
                                  setState(() {
                                    totalItem = 0;
                                    totalTransaksi = 0;
                                    biayaTambahan = 0;
                                    totalTransaksiAll = 0;
                                    for (var i = 0; i < data.length; i++) {
                                      totalItem += data[i].qty;
                                      totalTransaksi +=
                                          data[i].hargaSatuan * data[i].qty;
                                      biayaTambahan += data[i].biayaTambahan;
                                      totalTransaksiAll +=
                                          data[i].nominalTransaksi;
                                    }
                                  });
                                },
                                data: data[index],
                              );
                              // return Column(
                              //   children: [
                              //     SizedBox(
                              //       height: 10,
                              //     ),
                              //   ],
                              // );
                            },
                          )),
                      Container(
                        width: 375,
                        height: 58,
                        child: Row(
                          children: [
                            Container(
                              width: 162.5,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                setState(() {
                                  itemCounts++;
                                  data.add(NewTxCard(
                                      idTx: itemCounts,
                                      namaTransaksiBarang: "",
                                      tanggalTransaksi: "",
                                      akunDebit: "",
                                      akunKredit: "",
                                      qty: 0,
                                      hargaSatuan: 0,
                                      biayaTambahan: 0,
                                      nominalTransaksi: 0));
                                });
                              },
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.add_rounded,
                                  fill: 1,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      // SizedBox(
                      //     width: 375,
                      //     height: 310,
                      //     child: Column(
                      //       children: [
                      //         Row(children: [
                      //           Container(
                      //             width: 20,
                      //           ),
                      //           SizedBox(
                      //             width: 118,
                      //             height: 16,
                      //             child: AutoSizeText(
                      //               "Nama Transaksi/Barang",
                      //               minFontSize: 10,
                      //               maxFontSize: 12,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 33,
                      //           ),
                      //           SizedBox(
                      //             width: 184,
                      //             height: 16,
                      //             child: TextField(
                      //               controller: namaTransaksiController,
                      //               textInputAction: TextInputAction.next,
                      //               textAlign: TextAlign.end,
                      //               decoration: InputDecoration(
                      //                 border: InputBorder.none,
                      //                 contentPadding:
                      //                     EdgeInsets.fromLTRB(0, 0, 0, 0),
                      //               ),
                      //             ),
                      //           ),
                      //         ]),
                      //         const SizedBox(
                      //           height: 16,
                      //         ),
                      //         GestureDetector(
                      //             behavior: HitTestBehavior.opaque,
                      //             onTap: () async {
                      //               _selectDateRange(context);
                      //             },
                      //             child: SizedBox(
                      //               width: 375,
                      //               height: 44,
                      //               child: Row(
                      //                 children: [
                      //                   Container(
                      //                     width: 20,
                      //                   ),
                      //                   SizedBox(
                      //                     width: 118,
                      //                     height: 16,
                      //                     child: const Text(
                      //                       "Tanggal Transaksi",
                      //                     ),
                      //                   ),
                      //                   SizedBox(
                      //                     width: 33,
                      //                   ),
                      //                   SizedBox(
                      //                       width: 184,
                      //                       height: 16,
                      //                       child: AutoSizeText(
                      //                         '${_selectedDateRange.start.day}/${_selectedDateRange.start.month}/${_selectedDateRange.start.year}',
                      //                         textAlign: TextAlign.end,
                      //                         minFontSize: 10,
                      //                         maxFontSize: 12,
                      //                       ))
                      //                 ],
                      //               ),
                      //             )),
                      //         const SizedBox(
                      //           height: 16,
                      //         ),
                      //         Row(children: [
                      //           Container(
                      //             width: 20,
                      //           ),
                      //           SizedBox(
                      //             width: 118,
                      //             height: 16,
                      //             child: AutoSizeText(
                      //               "Debit",
                      //               minFontSize: 10,
                      //               maxFontSize: 12,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 33,
                      //           ),
                      //           SizedBox(
                      //               width: 184,
                      //               height: 16,
                      //               child: AutoSizeText(
                      //                 "Pilih Akun",
                      //                 textAlign: TextAlign.end,
                      //               )),
                      //         ]),
                      //         const SizedBox(
                      //           height: 16,
                      //         ),
                      //         Row(children: [
                      //           Container(
                      //             width: 20,
                      //           ),
                      //           SizedBox(
                      //             width: 118,
                      //             height: 16,
                      //             child: AutoSizeText(
                      //               "Kredit",
                      //               minFontSize: 10,
                      //               maxFontSize: 12,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 33,
                      //           ),
                      //           SizedBox(
                      //               width: 184,
                      //               height: 16,
                      //               child: AutoSizeText(
                      //                 "Pilih Akun",
                      //                 textAlign: TextAlign.end,
                      //               )),
                      //         ]),
                      //         const SizedBox(
                      //           height: 16,
                      //         ),
                      //         Row(children: [
                      //           Container(
                      //             width: 20,
                      //           ),
                      //           SizedBox(
                      //             width: 118,
                      //             height: 16,
                      //             child: AutoSizeText(
                      //               "Qty",
                      //               minFontSize: 10,
                      //               maxFontSize: 12,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 33,
                      //           ),
                      //           SizedBox(
                      //               width: 184,
                      //               height: 16,
                      //               child: AutoSizeText(
                      //                 "1",
                      //                 textAlign: TextAlign.end,
                      //               )),
                      //         ]),
                      //         const SizedBox(
                      //           height: 16,
                      //         ),
                      //         Row(children: [
                      //           Container(
                      //             width: 20,
                      //           ),
                      //           SizedBox(
                      //             width: 118,
                      //             height: 16,
                      //             child: AutoSizeText(
                      //               "Harga Satuan",
                      //               minFontSize: 10,
                      //               maxFontSize: 12,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 33,
                      //           ),
                      //           SizedBox(
                      //               width: 184,
                      //               height: 16,
                      //               child: AutoSizeText(
                      //                 "10.000",
                      //                 textAlign: TextAlign.end,
                      //               )),
                      //         ]),
                      //         const SizedBox(
                      //           height: 16,
                      //         ),
                      //         Row(children: [
                      //           Container(
                      //             width: 20,
                      //           ),
                      //           SizedBox(
                      //             width: 118,
                      //             height: 16,
                      //             child: AutoSizeText(
                      //               "Biaya Tambahan",
                      //               minFontSize: 10,
                      //               maxFontSize: 12,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 33,
                      //           ),
                      //           SizedBox(
                      //               width: 184,
                      //               height: 16,
                      //               child: AutoSizeText(
                      //                 "0",
                      //                 textAlign: TextAlign.end,
                      //               )),
                      //         ]),
                      //         const SizedBox(
                      //           height: 16,
                      //         ),
                      //         Row(children: [
                      //           Container(
                      //             width: 20,
                      //           ),
                      //           SizedBox(
                      //             width: 118,
                      //             height: 16,
                      //             child: AutoSizeText(
                      //               "Nominal Transaksi",
                      //               minFontSize: 10,
                      //               maxFontSize: 12,
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 33,
                      //           ),
                      //           SizedBox(
                      //               width: 184,
                      //               height: 16,
                      //               child: AutoSizeText(
                      //                 "10.000",
                      //                 textAlign: TextAlign.end,
                      //               )),
                      //         ]),
                      //         SizedBox(
                      //           height: 16,
                      //         ),
                      //         Container(
                      //           width: 335,
                      //           child: Row(children: [
                      //             SizedBox(
                      //               width: 264,
                      //             ),
                      //             SizedBox(
                      //                 // width: 184,
                      //                 height: 24,
                      //                 child: Row(
                      //                   children: [
                      //                     SizedBox(
                      //                       width: 34,
                      //                       height: 24,
                      //                       child: Center(
                      //                         child: Text(
                      //                           textAlign: TextAlign.center,
                      //                           "Delete",
                      //                           style: TextStyle(
                      //                             fontSize: 10,
                      //                             fontWeight: FontWeight.w500,
                      //                             fontFamily:
                      //                                 'Plus Jakarta Sans',
                      //                             color: Colors.red,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     SizedBox(
                      //                       width: 13,
                      //                     ),
                      //                     SvgPicture.asset(
                      //                       'assets/Trash_icon.svg',
                      //                       width: 24,
                      //                       height: 24,
                      //                       colorFilter: ColorFilter.mode(
                      //                           Colors.red, BlendMode.srcATop),
                      //                     ),
                      //                   ],
                      //                 )),
                      //           ]),
                      //         ),
                      //       ],
                      //     ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 375,
                height: 150,
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  children: [
                    Container(
                      width: 351,
                      height: 16,
                      child: Row(
                        children: [
                          Container(
                              width: 145, child: AutoSizeText("Total Item")),
                          SizedBox(
                            width: 100,
                          ),
                          Container(
                            width: 81,
                            child: AutoSizeText(
                              '$totalItem',
                              textAlign: TextAlign.end,
                              minFontSize: 10,
                              maxFontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: 351,
                      height: 16,
                      child: Row(
                        children: [
                          Container(
                              width: 145,
                              child: AutoSizeText("Total Transaksi")),
                          SizedBox(
                            width: 100,
                          ),
                          Container(
                            width: 81,
                            child: AutoSizeText(
                              '$totalTransaksi',
                              textAlign: TextAlign.end,
                              minFontSize: 10,
                              maxFontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: 351,
                      height: 16,
                      child: Row(
                        children: [
                          Container(
                              width: 145,
                              child: AutoSizeText("Total Biaya Tambahan")),
                          SizedBox(
                            width: 100,
                          ),
                          Container(
                            width: 81,
                            child: AutoSizeText(
                              '$biayaTambahan',
                              textAlign: TextAlign.end,
                              minFontSize: 10,
                              maxFontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: 351,
                      height: 16,
                      child: Row(
                        children: [
                          Container(
                              width: 145,
                              child: AutoSizeText(
                                "PPN (0 jika sudah termasuk)",
                                minFontSize: 10,
                                maxFontSize: 14,
                              )),
                          SizedBox(
                            width: 100,
                          ),
                          Container(
                            width: 81,
                            child: AutoSizeText(
                              "0",
                              textAlign: TextAlign.end,
                              minFontSize: 10,
                              maxFontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: 351,
                      height: 16,
                      child: Row(
                        children: [
                          Container(
                              width: 145,
                              child: AutoSizeText("Total Pengeluaran")),
                          SizedBox(
                            width: 100,
                          ),
                          Container(
                            width: 81,
                            child: AutoSizeText(
                              '$totalTransaksiAll',
                              textAlign: TextAlign.end,
                              minFontSize: 10,
                              maxFontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // buttonlarge3KS (117:3606)
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xff2c14dd),
                  borderRadius: BorderRadius.circular(100),
                ),

                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {},
                    child: const Center(
                      child: Text(
                        'Tambah',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.26,
                          color: Color(0xfffbfbfb),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ));
  }
}
