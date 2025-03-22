import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/pages/header.dart';
import 'package:uas_flutter/view/category/createCategory.dart';
import 'package:uas_flutter/helper/rupiah.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/models/transaksi-go.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';
import 'package:uas_flutter/view/transaksi/transaksi2.dart';

class EditTransaksiApp extends StatefulWidget {
  static const routeName = '/edittx';
  EditTransaksiApp({super.key, required this.IdTransaksi});
  final int IdTransaksi;

  @override
  State<EditTransaksiApp> createState() => EditTransaksi();
}

TextEditingController namaTransaksiController = TextEditingController();
TextEditingController nominalTransaksiController = TextEditingController();
TextEditingController tanggalTransaksiController = TextEditingController();
TextEditingController kategori = TextEditingController();
TextEditingController dompetTransaksiController = TextEditingController();

class EditTransaksi extends State<EditTransaksiApp> {
  GetTxModel? tagObjs;
  List<GetWalletModel> listWallet = [
    GetWalletModel(idWallet: 0, NamaWallet: " ", TotalSaldo: 0)
  ];
  GetWalletModel selectedwallet =
      GetWalletModel(idWallet: 0, NamaWallet: "", TotalSaldo: 0);
  String? dropdownWalletValue;
  List<GetJenisTransaksiModel> listJenisTransaksi = [
    GetJenisTransaksiModel(
        NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0)
  ];
  GetJenisTransaksiModel selectedjenisTransaksi = GetJenisTransaksiModel(
      NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0);
  String? dropdownJenisTransaksiValue;
  bool _validatenama = false;
  bool _validatenominal = false;
  String tanggal = "Pilih Tanggal";

  @override
  void initState() {
    super.initState();
    RecentTx();
    GetWallets();
    GetJenisTransaksi();
    _selectedDateRange;
    if (_selectedDateRange.start.day != 0 || _selectedDateRange.end.day != 0) {
      if (_selectedDateRange.start.day != 0 &&
          _selectedDateRange.end.day != 0) {
        tanggal =
            '${_selectedDateRange.start.day}/${_selectedDateRange.start.month}/${_selectedDateRange.start.year} - ${_selectedDateRange.end.day}/${_selectedDateRange.end.month}/${_selectedDateRange.end.year}';
      } else if (_selectedDateRange.start.day != 0) {
        tanggal =
            '${_selectedDateRange.start.year}/${_selectedDateRange.start.month}/${_selectedDateRange.start.day}';
      } else {
        tanggal =
            '${_selectedDateRange.end.year}/${_selectedDateRange.end.month}/${_selectedDateRange.end.day}';
      }
    } else {
      tanggal = "Pilih Tanggal";
    }
  }

  final DateTime now = DateTime.now();

  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(Duration(days: 365)),
    end: DateTime.now(),
  );
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
        if (_selectedDateRange.start.day != 0 ||
            _selectedDateRange.end.day != 0) {
          if (_selectedDateRange.start.day != 0 &&
              _selectedDateRange.end.day != 0) {
            tanggal =
                '${_selectedDateRange.start.day}/${_selectedDateRange.start.month}/${_selectedDateRange.start.year} - ${_selectedDateRange.end.day}/${_selectedDateRange.end.month}/${_selectedDateRange.end.year}';
          } else if (_selectedDateRange.start.day != 0) {
            tanggal =
                '${_selectedDateRange.start.year}/${_selectedDateRange.start.month}/${_selectedDateRange.start.day}';
          } else {
            tanggal =
                '${_selectedDateRange.end.year}/${_selectedDateRange.end.month}/${_selectedDateRange.end.day}';
          }
        } else {
          tanggal = "Pilih Tanggal";
        }
        RecentTx();
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Selected range: ${picked.start.day}/${picked.start.month}/${picked.start.year} - ${picked.end.day}/${picked.end.month}/${picked.end.year}',
        ),
      ));
    }
  }

  GetData() async {
    GetWallets();
    RecentTx();
    GetJenisTransaksi();
  }

  RecentTx() async {
    print("widget.IdTransaksi");
    print(widget.IdTransaksi);
    final gettxs = await context
        .read<TransaksiCubit>()
        .getTxOne(id: widget.IdTransaksi.toString());
    gettxs.fold((failure) {}, (data) {
      setState(() {
        nominalTransaksiController.text =
            CurrencyFormat.convertToIdr(data.nominal, 0);
        namaTransaksiController.text = data.KeteranganTransaksi;
        tagObjs = data;
      });
    });
  }

  GetWallets() async {
    var getwallets = GetWalletDataStorage();
//     if (tagObjs != null) {
//       var selecttx = getwallets
//           .where((wallet) => wallet.idWallet == tagObjs?.idCoa)
//           .toList();
//       setState(() {
//         // selectedwallet ??= listWallet!.first;
// // selectedjenisTransaksi ??= listJenisTransaksi!.first;
//       });
//     }
    setState(() {
      listWallet = getwallets;
      selectedwallet = listWallet.first;
      dropdownWalletValue = getwallets.first.NamaWallet;
      listWallet.add(GetWalletModel(
          NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0));
    });
  }

  GetJenisTransaksi() async {
    final getjenisTx = await context.read<TransaksiCubit>().getJenisTransaksi();
    getjenisTx.fold((failure) {
      setState(() {
        listJenisTransaksi.clear();
        listJenisTransaksi = [
          GetJenisTransaksiModel(
              NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0)
        ];
      });
    }, (data) {
      if (tagObjs != null) {
        // var selecttx = data
        //     .where((jenistx) =>
        //         jenistx.idJenisTransaksi == tagObjs?.idJenisTransaksi)
        //     .toList();
        // setState(() {
        //   selectedjenisTransaksi = selecttx.first;
        // });
      }
      setState(() {
        listJenisTransaksi.clear();
        listJenisTransaksi = [
          GetJenisTransaksiModel(
              NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0)
        ];
        //  ,GetJenisTransaksiModel(NamaJenisTransaksi: "Select Kategori", idJenisTransaksi: 0)];
        listJenisTransaksi.addAll(data);
        dropdownJenisTransaksiValue = data.first.NamaJenisTransaksi;
        selectedjenisTransaksi = listJenisTransaksi.first;
        // listJenisTransaksi.add(GetJenisTransaksiModel(
        // NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0));
      });
    });
  }

  String? error;
  var debit1 = false, debit2 = false, kredit1 = false, kredit2 = false;
  @override
  Widget build(BuildContext context) {
    print("listJenisTransaksi");
    print(listJenisTransaksi);
    for (var i = 0; i < listJenisTransaksi.length; i++) {
      print(listJenisTransaksi[i].NamaJenisTransaksi);
      print(listJenisTransaksi[i].idJenisTransaksi);
    }
    print("selectedjenisTransaksi");
    print(selectedjenisTransaksi.idJenisTransaksi);
    print(selectedjenisTransaksi.NamaJenisTransaksi);
    return BlocListener<TransaksiCubit, TransaksiState>(
        listener: (context, state) {
          state.whenOrNull(
            failed: (String? e) {
              setState(() {
                error = e;
              });
            },
          );
        },
        child: Scaffold(
            appBar: HeaderCard(
              namaMenu: "Edit Transaksi",
            ),
            body: SingleChildScrollView(
                child: Container(
              width: 375,
              decoration: const BoxDecoration(
                color: Color(0xffF5F7FF),
              ),
              child: Column(children: [
                const SizedBox(
                  height: 3,
                ),
                Container(
                  width: 335,
                  // height: 575,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(children: [
                    Container(
                        child: const Center(
                      child: Text(
                        "NOMINAL TRANSAKSI",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
                    Container(
                      width: 335,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 217, 217, 217),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: SizedBox(
                        // margin: const EdgeInsets.fromLTRB(104, 0, 0, 0),
                        child: TextFormField(
                          controller: nominalTransaksiController,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(240, 29, 1, 214)),
                            errorText: _validatenominal
                                ? "Nominal Tidak Boleh Kosong"
                                : null,
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            CurrencyTextInputFormatter.currency(
                                locale: "id-ID",
                                decimalDigits: 0,
                                symbol: "Rp ")
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: 335,
                      height: 33,
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        children: [
                          Container(
                              width: 99,
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(117, 0, 102, 255),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0, 2),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        nominalTransaksiController.text =
                                            CurrencyFormat.convertToIdr(
                                                100000, 2);
                                      });
                                    },
                                    child: Text(
                                      "Rp 100,000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 44, 20, 221)),
                                    )),
                              )),
                          const SizedBox(
                            width: 3,
                          ),
                          Container(
                              width: 99,
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(117, 0, 102, 255),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0, 2),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    nominalTransaksiController.text =
                                        CurrencyFormat.convertToIdr(500000, 2);
                                  });
                                },
                                child: Text(
                                  "Rp 500,000",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 44, 20, 221)),
                                ),
                              ))),
                          const SizedBox(
                            width: 7,
                          ),
                          Container(
                              width: 99,
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(117, 0, 102, 255),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0, 2),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    nominalTransaksiController.text =
                                        CurrencyFormat.convertToIdr(1000000, 2);
                                  });
                                },
                                child: Text(
                                  "Rp 1,000,000",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 44, 20, 221)),
                                ),
                              ))),
                        ],
                      ),
                    ),
                    Container(
                      width: 335,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        shape: BoxShape.rectangle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0c000000),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                      child: Container(
                        width: 320,
                        height: 55,
                        margin: EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text("Nama Transaksi"),
                              ),
                              Container(
                                width: 320,
                                height: 40,
                                color: Color.fromARGB(255, 217, 217, 217),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: namaTransaksiController,
                                  textAlign: TextAlign.left,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    errorText: _validatenama
                                        ? "Nama Transaksi tidak boleh kosong"
                                        : null,
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ),
                    Container(
                      width: 343,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: const Color(0xffffffff),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0c000000),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                width: 320,
                                height: 56,
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                    width: 320,
                                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () async {
                                          _selectDateRange(context);
                                        },
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 240,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                                  child: const Text(
                                                    "Rentang Tanggal Transaksi",
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  width: 240,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  // color: const Color.fromRGBO(
                                                  //     217, 217, 217, 1),
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                                  child: Text(tanggal,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xff3E3E3E),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                                width: 40,
                                                height: 40,
                                                child: SvgPicture.asset(
                                                  'assets/Calendar.svg',
                                                ))
                                          ],
                                        )))),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 335,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: const Color(0xffffffff),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0c000000),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        children: [
                          Container(
                              width: 300,
                              height: 80,
                              margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    _selectDateRange(context);
                                  },
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 240,
                                            alignment: Alignment.centerLeft,
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: const Text(
                                              "Kategori",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 240,
                                            child:
                                                // Container(),
                                                DropdownButton<
                                                        GetJenisTransaksiModel>(
                                                    underline: const SizedBox(),
                                                    value:
                                                        selectedjenisTransaksi,
                                                    onChanged:
                                                        (GetJenisTransaksiModel?
                                                            value) {
                                                      setState(() {
                                                        selectedjenisTransaksi =
                                                            value!;
                                                        RecentTx();
                                                      });
                                                      if (dropdownJenisTransaksiValue ==
                                                          "Create Kategori") {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const CreateCategoriesApp()));
                                                      }
                                                    },
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 0),
                                                    icon: const Visibility(
                                                        visible: false,
                                                        child: Icon(Icons
                                                            .arrow_downward)),
                                                    items: listJenisTransaksi.map(
                                                        (GetJenisTransaksiModel
                                                            value) {
                                                      return DropdownMenuItem<
                                                              GetJenisTransaksiModel>(
                                                          value: value,
                                                          child:
                                                              Wrap(children: [
                                                            Text(value
                                                                .NamaJenisTransaksi),
                                                          ]));
                                                    }).toList()),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        width: 30,
                                        height: 30,
                                        child: SvgPicture.asset(
                                          'assets/chevron-left.svg',
                                          height: 16,
                                          width: 16,
                                        ),
                                      ),
                                    ],
                                  )))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: 335,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: const Color(0xffffffff),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0c000000),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        children: [
                          Container(
                              width: 300,
                              height: 90,
                              margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    _selectDateRange(context);
                                  },
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 240,
                                            alignment: Alignment.centerLeft,
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: const Text(
                                              "Pilih Akun",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(
                                              child: Row(
                                            children: [
                                              Container(
                                                // frame204Jp (116:2555)
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 8, 0),
                                                width: 18,
                                                height: 18,
                                                child: SvgPicture.asset(
                                                  'assets/Logo.svg',
                                                  height: 18,
                                                  width: 18,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 220,
                                                child:
                                                    // Container(),
                                                    DropdownButton<
                                                            GetJenisTransaksiModel>(
                                                        underline:
                                                            const SizedBox(),
                                                        value:
                                                            selectedjenisTransaksi,
                                                        onChanged:
                                                            (GetJenisTransaksiModel?
                                                                value) {
                                                          setState(() {
                                                            selectedjenisTransaksi =
                                                                value!;
                                                            RecentTx();
                                                          });
                                                          if (dropdownJenisTransaksiValue ==
                                                              "Create Kategori") {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const CreateCategoriesApp()));
                                                          }
                                                        },
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 0, 0, 0),
                                                        icon: const Visibility(
                                                            visible: false,
                                                            child: Icon(Icons
                                                                .arrow_downward)),
                                                        items: listJenisTransaksi
                                                            .map(
                                                                (GetJenisTransaksiModel
                                                                    value) {
                                                          return DropdownMenuItem<
                                                                  GetJenisTransaksiModel>(
                                                              value: value,
                                                              child: Wrap(
                                                                  children: [
                                                                    Text(value
                                                                        .NamaJenisTransaksi),
                                                                  ]));
                                                        }).toList()),
                                              ),
                                            ],
                                          )),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        width: 30,
                                        height: 30,
                                        child: SvgPicture.asset(
                                          'assets/chevron-left.svg',
                                          height: 16,
                                          width: 16,
                                        ),
                                      ),
                                    ],
                                  )))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: 335,
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  debit1 = true;
                                  kredit1 = false;
                                });
                              },
                              child: Container(
                                width: 163,
                                height: 34,
                                margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: debit1
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : null,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x3fe7e7e7),
                                      offset: Offset(0, 4),
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Debit',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 1.26,
                                      color: Color(0xff131313),
                                    ),
                                  ),
                                ),
                              )),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                debit1 = false;
                                kredit1 = true;
                              });
                            },
                            child: Container(
                              width: 163,
                              height: 34,
                              margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: kredit1
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : null,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x3fe7e7e7),
                                    offset: Offset(0, 4),
                                    blurRadius: 1,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Kredit',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.26,
                                    color: Color(0xff131313),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 335,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: const Color(0xffffffff),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0c000000),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Row(
                        children: [
                          Container(
                              width: 300,
                              height: 90,
                              margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    _selectDateRange(context);
                                  },
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 240,
                                            alignment: Alignment.centerLeft,
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: const Text(
                                              "Pilih Akun",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(
                                              child: Row(
                                            children: [
                                              Container(
                                                // frame204Jp (116:2555)
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 8, 0),
                                                width: 18,
                                                height: 18,
                                                child: SvgPicture.asset(
                                                  'assets/Logo.svg',
                                                  height: 18,
                                                  width: 18,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 220,
                                                child:
                                                    // Container(),
                                                    DropdownButton<
                                                            GetJenisTransaksiModel>(
                                                        underline:
                                                            const SizedBox(),
                                                        value:
                                                            selectedjenisTransaksi,
                                                        onChanged:
                                                            (GetJenisTransaksiModel?
                                                                value) {
                                                          setState(() {
                                                            selectedjenisTransaksi =
                                                                value!;
                                                            RecentTx();
                                                          });
                                                          if (dropdownJenisTransaksiValue ==
                                                              "Create Kategori") {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const CreateCategoriesApp()));
                                                          }
                                                        },
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 0, 0, 0),
                                                        icon: const Visibility(
                                                            visible: false,
                                                            child: Icon(Icons
                                                                .arrow_downward)),
                                                        items: listJenisTransaksi
                                                            .map(
                                                                (GetJenisTransaksiModel
                                                                    value) {
                                                          return DropdownMenuItem<
                                                                  GetJenisTransaksiModel>(
                                                              value: value,
                                                              child: Wrap(
                                                                  children: [
                                                                    Text(value
                                                                        .NamaJenisTransaksi),
                                                                  ]));
                                                        }).toList()),
                                              ),
                                            ],
                                          )),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        width: 30,
                                        height: 30,
                                        child: SvgPicture.asset(
                                          'assets/chevron-left.svg',
                                          height: 16,
                                          width: 16,
                                        ),
                                      ),
                                    ],
                                  )))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: 335,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                kredit2 = false;
                                debit2 = true;
                              });
                            },
                            child: Container(
                              width: 163,
                              height: 34,
                              margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: debit2
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : null,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x3fe7e7e7),
                                    offset: Offset(0, 4),
                                    blurRadius: 1,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Debit',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.26,
                                    color: Color(0xff131313),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                kredit2 = true;
                                debit2 = false;
                              });
                            },
                            child: Container(
                              width: 163,
                              height: 34,
                              margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: kredit2
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : null,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x3fe7e7e7),
                                    offset: Offset(0, 4),
                                    blurRadius: 1,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Kredit',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.26,
                                    color: Color(0xff131313),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        height: 48,
                        width: 312,
                        child: Row(
                          children: [
                            // SizedBox(
                            //   width: 39,
                            // ),
                            Container(
                              // buttonlarge3KS (117:3606)
                              // margin: const EdgeInsets.fromLTRB(0, 0, 14, 0),
                              width: 156,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xff2c14dd),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    TimeOfDay currentTime = TimeOfDay.now();
                                    setState(() {
                                      _validatenominal =
                                          nominalTransaksiController
                                              .text.isEmpty;
                                      _validatenama =
                                          namaTransaksiController.text.isEmpty;
                                    });
                                    if (!_validatenama && !_validatenominal) {
                                      TransaksiGo input = TransaksiGo(
                                          idTransaksi: widget.IdTransaksi,
                                          keteranganTransaksi:
                                              namaTransaksiController.text,
                                          idJenisTransaksi:
                                              selectedjenisTransaksi
                                                  .idJenisTransaksi,
                                          tglTransaksi: tanggal,
                                          waktuTransaksi:
                                              currentTime.format(context),
                                          nominal: double.parse(
                                              nominalTransaksiController.text
                                                  .replaceAll(
                                                      RegExp(
                                                          r'(?:_|[^\w\s\r])+'),
                                                      '')
                                                  // .replaceAll("IDR", '')
                                                  .replaceAll("Rp ", '')
                                                  .toString()),
                                          idUser: 0,
                                          idWallet: selectedwallet.idWallet);
                                      var resultcreate =
                                          await TransaksiRepository()
                                              .CreateTransaksi(input);
                                      if (resultcreate.code != "200") {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: const Text(
                                                    "Gagal Tambahkan Transaksi"),
                                                // content: Text("tokennya$token"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                        context,
                                                      );
                                                    },
                                                    child:
                                                        const Text("Kembali"),
                                                  )
                                                ]);
                                          },
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: const Text(
                                                    "Sukses Ubah Transaksi"),
                                                // content: Text("tokennya$token"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  // WelcomeApp()
                                                                  Transaksi2App()));
                                                    },
                                                    child:
                                                        const Text("Dashboard"),
                                                  )
                                                ]);
                                          },
                                        );
                                      }
                                    }
                                  },
                                  child: const Center(
                                    child: Text(
                                      'Ubah',
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
                            Container(
                              // buttonlarge3KS (117:3606)
                              // margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                              width: 156,
                              height: 48,
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.red, width: 2),
                              ),
                              child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {},
                                  child: Center(
                                      child: Container(
                                    color: Colors.white,
                                    child: Text(
                                      'Hapus',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        height: 1.26,
                                        color: Color.fromARGB(255, 255, 0, 0),
                                      ),
                                    ),
                                  ))),
                            ),
                          ],
                        )),
                  ]),
                ),
              ]),
            ))));
  }
}
