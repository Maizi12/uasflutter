import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/models/new-tx-card.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';
import 'package:uas_flutter/view/category/createCategory.dart';

class CreateNewTxCardApp extends StatefulWidget {
  const CreateNewTxCardApp({
    super.key,
    required this.onremove,
    required this.onupdate,
    required this.data,
  });
  final VoidCallback? onremove;
  final VoidCallback? onupdate;
  final NewTxCard data;
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
  State<CreateNewTxCardApp> createState() => CreateNewTxCard();
}

class CreateNewTxCard extends State<CreateNewTxCardApp> {
  @override
  void initState() {
    super.initState();
    GetWallet();
    qtyController.text = "0";
    hargaSatuanController.text = "0";
    biayaTambahanController.text = "0";
    nominalTransaksiController.text = "0";
  }

  TextEditingController namaTransaksiController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController hargaSatuanController = TextEditingController();
  TextEditingController biayaTambahanController = TextEditingController();
  TextEditingController nominalTransaksiController = TextEditingController();
  String tanggal = "";
  final DateTime now = DateTime.now();
  GetWalletModel selectedlistDebit =
      GetWalletModel(NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0);
  List<GetWalletModel> listDebit = [
    GetWalletModel(idWallet: 0, NamaWallet: "Create Wallet", TotalSaldo: 0)
  ];
  GetWalletModel selectedlistKredit =
      GetWalletModel(NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0);
  List<GetWalletModel> listKredit = [
    GetWalletModel(idWallet: 0, NamaWallet: "Create Wallet", TotalSaldo: 0)
  ];
  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(Duration(days: 365)),
    end: DateTime.now(),
  );
  GetWallet() async {
    var getwall = GetWalletDataStorage();
    setState(() {
      if (getwall.isNotEmpty) {
        listDebit.clear();
        selectedlistDebit = getwall.first; //harus array first kayaknya
        listDebit.addAll(getwall);
        listDebit.add(GetWalletModel(
            NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0));
        listKredit.clear();
        selectedlistKredit = getwall.first; //harus array first kayaknya
        listKredit.addAll(getwall);
        listKredit.add(GetWalletModel(
            NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0));
      }
    });
    if (getwall.isEmpty) {
      listDebit.clear();
      listDebit = [
        GetWalletModel(
            idWallet: 2, NamaWallet: "Create Wallets", TotalSaldo: 1),
      ];
      listKredit.clear();
      listKredit = [
        GetWalletModel(
            idWallet: 2, NamaWallet: "Create Wallets", TotalSaldo: 1),
      ];
    }
  }

  UpdateNominalTransaksi() async {
    nominalTransaksiController.text =
        ((double.parse(hargaSatuanController.text) *
                    double.parse(qtyController.text)) +
                double.parse(biayaTambahanController.text))
            .toString();
    widget.data.nominalTransaksi =
        double.parse(nominalTransaksiController.text);
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange initialDateRange = _selectedDateRange;
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 1),
      initialDateRange: initialDateRange,
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
        widget.data.tanggalTransaksi =
            '${picked.start.day}/${picked.start.month}/${picked.start.year}';
        if (widget.onupdate != null) {
          widget.onupdate!(); // Call the function
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Selected range: ${picked.start.day}/${picked.start.month}/${picked.start.year} - ${picked.end.day}/${picked.end.month}/${picked.end.year}',
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 375,
        height: 310,
        child: Column(
          children: [
            Row(children: [
              Container(
                width: 20,
              ),
              SizedBox(
                width: 118,
                height: 16,
                child: AutoSizeText(
                  "Nama Transaksi/Barang",
                  minFontSize: 10,
                  maxFontSize: 12,
                ),
              ),
              SizedBox(
                width: 33,
              ),
              SizedBox(
                width: 184,
                height: 16,
                child: TextField(
                  controller: namaTransaksiController,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.end,
                  onChanged: (value) {
                    setState(() {
                      widget.data.namaTransaksiBarang =
                          namaTransaksiController.text;
                      if (widget.onupdate != null) {
                        widget.onupdate!(); // Call the function
                      }
                    });
                  },
                ),
              ),
            ]),
            const SizedBox(
              height: 16,
            ),
            Container(
              child: GestureDetector(
                
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    _selectDateRange(context);
                  },
                  child: SizedBox(
                    width: 375,
                    height: 44,
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                        ),
                        SizedBox(
                          width: 118,
                          height: 16,
                          child: const Text(
                            "Tanggal Transaksi",
                          ),
                        ),
                        SizedBox(
                          width: 33,
                        ),
                        SizedBox(
                            width: 184,
                            height: 16,
                            child: AutoSizeText(
                              '${_selectedDateRange.start.day}/${_selectedDateRange.start.month}/${_selectedDateRange.start.year}',
                              textAlign: TextAlign.end,
                              minFontSize: 10,
                              maxFontSize: 12,
                            ))
                      ],
                    ),
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(children: [
              Container(
                width: 20,
              ),
              SizedBox(
                width: 118,
                height: 16,
                child: AutoSizeText(
                  "Debit",
                  minFontSize: 10,
                  maxFontSize: 12,
                ),
              ),
              SizedBox(
                width: 33,
              ),
              SizedBox(
                width: 184,
                height: 16,
                child: DropdownButton<GetWalletModel>(
                  value: selectedlistDebit,
                  alignment: Alignment.centerRight,
                  icon: Visibility(
                    child: Icon(Icons.arrow_downward),
                    visible: false,
                  ),
                  underline: const SizedBox(),
                  selectedItemBuilder: (BuildContext context) {
                    return listDebit.map<Widget>((GetWalletModel values) {
                      return SizedBox(
                          width: 184,
                          child: AutoSizeText(
                            minFontSize: 10,
                            maxFontSize: 12,
                            values.NamaWallet,
                            textAlign: TextAlign.right,
                          ));
                    }).toList();
                  },
                  items: listDebit.map((GetWalletModel values) {
                    return DropdownMenuItem<GetWalletModel>(
                        value: values,
                        child: Container(
                            width: 184,
                            // alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              minFontSize: 10,
                              maxFontSize: 12,
                              values.NamaWallet,
                              // textAlign: TextAlign.right,
                            )));
                  }).toList(),
                  onChanged: (GetWalletModel? value) {
                    setState(() {
                      widget.data.akunDebit = value!.NamaWallet;
                      if (widget.onupdate != null) {
                        widget.onupdate!(); // Call the function
                      }
                    });
                    if (value!.NamaWallet == "Create Wallet") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CreateCategoriesApp()));
                    }
                  },
                  hint: AutoSizeText(
                    "Pilih Akun",
                    textAlign: TextAlign.end,
                  ),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
              ),
            ]),
            const SizedBox(
              height: 16,
            ),
            Row(children: [
              Container(
                width: 20,
              ),
              SizedBox(
                width: 118,
                height: 16,
                child: AutoSizeText(
                  "Kredit",
                  minFontSize: 10,
                  maxFontSize: 12,
                ),
              ),
              SizedBox(
                width: 33,
              ),
              SizedBox(
                width: 184,
                height: 16,
                child: DropdownButton<GetWalletModel>(
                  alignment: Alignment.centerRight,
                  value: selectedlistKredit,
                  underline: const SizedBox(),
                  icon: Visibility(
                    child: Icon(Icons.arrow_downward),
                    visible: false,
                  ),
                  selectedItemBuilder: (BuildContext context) {
                    return listKredit.map<Widget>((GetWalletModel values) {
                      return SizedBox(
                          width: 184,
                          child: AutoSizeText(
                            minFontSize: 10,
                            maxFontSize: 12,
                            values.NamaWallet,
                            textAlign: TextAlign.right,
                          ));
                    }).toList();
                  },
                  items: listKredit.map((GetWalletModel values) {
                    return DropdownMenuItem<GetWalletModel>(
                        value: values,
                        child: Container(
                            width: 184,
                            // alignment: Alignment.centerRight,
                            child: AutoSizeText(
                              minFontSize: 10,
                              maxFontSize: 12,
                              values.NamaWallet,
                              // textAlign: TextAlign.right,
                            )));
                  }).toList(),
                  onChanged: (GetWalletModel? value) {
                    setState(() {
                      widget.data.akunKredit = value!.NamaWallet;
                      if (widget.onupdate != null) {
                        widget.onupdate!(); // Call the function
                      }
                    });
                    if (value!.NamaWallet == "Create Wallet") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CreateCategoriesApp()));
                    }
                  },
                  hint: AutoSizeText(
                    "Pilih Akun",
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 16,
            ),
            Row(children: [
              Container(
                width: 20,
              ),
              SizedBox(
                width: 118,
                height: 16,
                child: AutoSizeText(
                  "Qty",
                  minFontSize: 10,
                  maxFontSize: 12,
                ),
              ),
              SizedBox(
                width: 33,
              ),
              SizedBox(
                width: 184,
                height: 16,
                child: TextField(
                  controller: qtyController,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.end,
                  onChanged: (value) {
                    setState(() {
                      widget.data.qty = int.parse(qtyController.text);
                      UpdateNominalTransaksi();
                      if (widget.onupdate != null) {
                        widget.onupdate!(); // Call the function
                      }
                    });
                  },
                ),
              ),
            ]),
            const SizedBox(
              height: 16,
            ),
            Row(children: [
              Container(
                width: 20,
              ),
              SizedBox(
                width: 118,
                height: 16,
                child: AutoSizeText(
                  "Harga Satuan",
                  minFontSize: 10,
                  maxFontSize: 12,
                ),
              ),
              SizedBox(
                width: 33,
              ),
              SizedBox(
                width: 184,
                height: 16,
                child: TextField(
                  controller: hargaSatuanController,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.end,
                  onChanged: (value) {
                    setState(() {
                      widget.data.hargaSatuan =
                          double.parse(hargaSatuanController.text);
                      UpdateNominalTransaksi();
                      if (widget.onupdate != null) {
                        widget.onupdate!(); // Call the function
                      }
                    });
                  },
                ),
              ),
            ]),
            const SizedBox(
              height: 16,
            ),
            Row(children: [
              Container(
                width: 20,
              ),
              SizedBox(
                  width: 118,
                  height: 16,
                  child: AutoSizeText(
                    "Biaya Tambahan",
                    minFontSize: 10,
                    maxFontSize: 12,
                  )),
              SizedBox(
                width: 33,
              ),
              SizedBox(
                width: 184,
                height: 16,
                child: TextField(
                  controller: biayaTambahanController,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.end,
                  onChanged: (value) {
                    setState(() {
                      widget.data.biayaTambahan =
                          double.parse(biayaTambahanController.text);
                      UpdateNominalTransaksi();
                      if (widget.onupdate != null) {
                        widget.onupdate!(); // Call the function
                      }
                    });
                  },
                ),
              ),
            ]),
            const SizedBox(
              height: 16,
            ),
            Row(children: [
              Container(
                width: 20,
              ),
              SizedBox(
                width: 118,
                height: 16,
                child: AutoSizeText(
                  "Nominal Transaksi",
                  minFontSize: 10,
                  maxFontSize: 12,
                ),
              ),
              SizedBox(
                width: 33,
              ),
              SizedBox(
                width: 184,
                height: 16,
                child: TextField(
                  controller: nominalTransaksiController,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.end,
                  onChanged: (value) {
                    setState(() {
                      widget.data.nominalTransaksi =
                          double.parse(nominalTransaksiController.text);
                      // widget.onupdate;
                      if (widget.onupdate != null) {
                        widget.onupdate!(); // Call the function
                      }
                    });
                  },
                ),
              ),
            ]),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 335,
              child: Row(children: [
                SizedBox(
                  width: 264,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      if (widget.onremove != null) {
                        widget.onremove!(); // Call the function
                      }
                      widget.onremove;
                    });
                  },
                  child: SizedBox(
                      // width: 184,
                      height: 24,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 34,
                            height: 24,
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                "Delete",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          SvgPicture.asset(
                            'assets/Trash_icon.svg',
                            width: 24,
                            height: 24,
                            colorFilter:
                                ColorFilter.mode(Colors.red, BlendMode.srcATop),
                          ),
                        ],
                      )),
                ),
              ]),
            ),
          ],
        ));
  }
}
