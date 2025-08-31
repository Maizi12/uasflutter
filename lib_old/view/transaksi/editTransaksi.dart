import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:uas_flutter/constant/appconstants.dart';
import 'package:uas_flutter/models/transaksi-go.dart';
import 'package:uas_flutter/pages/components/dropdown-wallet.dart';
import 'package:uas_flutter/pages/components/header.dart';
import 'package:uas_flutter/pages/components/select-date.dart';
import 'package:uas_flutter/util/data-fetch/recenttx-helper.dart';
import 'package:uas_flutter/util/data-fetch/wallet_helper.dart';
import 'package:uas_flutter/view/category/createCategory.dart';
import 'package:uas_flutter/helper/rupiah.dart';
import 'package:uas_flutter/models/response-go.dart';
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
  GetWalletModel selectedlistDebit = GetWalletModel(
      NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0, KodeCoa: "");
  List<GetWalletModel> listDebit = [
    GetWalletModel(
        idWallet: 0, NamaWallet: "Create Wallet", TotalSaldo: 0, KodeCoa: "")
  ];
  GetWalletModel selectedlistKredit = GetWalletModel(
      NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0, KodeCoa: "");
  List<GetWalletModel> listKredit = [
    GetWalletModel(
        idWallet: 0, NamaWallet: "Create Wallet", TotalSaldo: 0, KodeCoa: "")
  ];
  GetWalletModel selectedlistWallet = GetWalletModel(
      NamaWallet: "Create", idWallet: 0, TotalSaldo: 0, KodeCoa: "");
  GetTxModelDetail? tagObjs;
  List<GetWalletModel> listWallet = [
    GetWalletModel(idWallet: 0, NamaWallet: " ", TotalSaldo: 0, KodeCoa: "")
  ];
  String? dropdownWalletValue;
  String tgl = DateFormat.yMMMMd("id_ID").format(DateTime.now());

  bool _validatenama = false;
  bool _validatenominal = false;

  @override
  void initState() {
    super.initState();
    RecentTx();
    LoadCoa();
  }

  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final DateTime now = DateTime.now();

  GetData() async {
    LoadCoa();
    RecentTx();
  }

  void RecentTx() async {
    final tx = await RecentTxOne(context, widget.IdTransaksi);
    if (tx.idTransaksi != 0) {
      setState(() {
        tagObjs = tx;
        nominalTransaksiController.text =
            CurrencyFormat.convertToIdr(tx.nominal, 0);
        namaTransaksiController.text = tx.KeteranganTransaksi;
        tgl = tx.TanggalTransaksi;
        selectedlistDebit = GetWalletModel(
            idWallet: tx.idCoaDebit,
            NamaWallet: tx.NamaCoaDebit,
            TotalSaldo: tx.SaldoDebit,
            KodeCoa: tx.KodeCoaDebit);
        selectedlistKredit = GetWalletModel(
            idWallet: tx.idCoaKredit,
            NamaWallet: tx.NamaCoaKredit,
            TotalSaldo: tx.SaldoKredit,
            KodeCoa: tx.KodeCoaKredit);
      });
    }
  }

  void LoadCoa() async {
    final wallets = await fetchWallet(context);
    if (wallets.isNotEmpty) {
      setState(() {
        listWallet.clear();
        listWallet.addAll(wallets);
        selectedlistWallet = (listWallet.isNotEmpty ? listWallet.first : null)!;
        listDebit.clear();
        listKredit.clear();
        for (var i = 0; i < wallets.length; i++) {
          if (wallets[i].idWallet != selectedlistDebit.idWallet) {
            listDebit.add(wallets[i]);
          }
          if (wallets[i].idWallet != selectedlistKredit.idWallet) {
            listKredit.add(wallets[i]);
          }
        }
        listDebit.add(GetWalletModel(
            NamaWallet: "Create Wallet",
            idWallet: 0,
            TotalSaldo: 0,
            KodeCoa: ""));
        listKredit.add(GetWalletModel(
            NamaWallet: "Create Wallet",
            idWallet: 0,
            TotalSaldo: 0,
            KodeCoa: ""));
      });
      RecentTx();
    }
  }

  String? error;
  var debit1 = false, debit2 = false, kredit1 = false, kredit2 = false;
  @override
  Widget build(BuildContext context) {
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
                                margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: Container(
                                  width: 320,
                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: SelectDateApp(
                                    onDateSelected: (DateTime date) {
                                      setState(() {
                                        selectedDate = date;
                                        var month = date.month < 10
                                            ? "0${date.month}"
                                            : date.month.toString();
                                        var day = date.day < 10
                                            ? "0${date.day}"
                                            : date.day.toString();
                                        tagObjs?.TanggalTransaksi =
                                            '${date.year}-$month-${day}T00:00:00+07:00';
                                      });
                                    },
                                    tgl: (String tgls) {
                                      tgl = tgls;
                                    },
                                    child: SelectDateEditTx(
                                      selectedDate: tgl,
                                    ),
                                  ),
                                )),
                          ),
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
                      margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Row(
                        children: [
                          Container(
                              width: 300,
                              height: 90,
                              margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  // onTap: () async {
                                  //   _selectDateRange(context);
                                  // },
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
                                              "Pilih Akun Debit",
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
                                              Container(
                                                width: 200,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                child:
                                                    // Container(),
                                                    DropdownWalletApp(
                                                  selectedcoa:
                                                      selectedlistDebit,
                                                  selectCoa:
                                                      (GetWalletModel select) {
                                                    selectedlistDebit = select;
                                                    context
                                                        .read<TransaksiCubit>()
                                                        .selectWallet(select);
                                                  },
                                                  onupdate: () {},
                                                  ListCoa: listDebit,
                                                ),
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
                                  // onTap: () async {
                                  //   _selectDateRange(context);
                                  // },
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
                                              "Pilih Akun Kredit",
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
                                                    DropdownWalletApp(
                                                  selectedcoa:
                                                      selectedlistKredit,
                                                  selectCoa:
                                                      (GetWalletModel select) {
                                                    selectedlistKredit = select;
                                                    context
                                                        .read<TransaksiCubit>()
                                                        .selectWallet(select);
                                                  },
                                                  onupdate: () {},
                                                  ListCoa: listKredit,
                                                ),
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
                                        tglTransaksi:
                                            selectedDate.toIso8601String(),
                                        nominal: double.parse(
                                            nominalTransaksiController.text
                                                .replaceAll(
                                                    RegExp(r'(?:_|[^\w\s\r])+'),
                                                    '')
                                                // .replaceAll("IDR", '')
                                                .replaceAll("Rp ", '')
                                                .toString()),
                                        idUser: 0,
                                        idCoaDebit: selectedlistDebit.idWallet,
                                        idCoaKredit:
                                            selectedlistKredit.idWallet,
                                      );
                                      var resultcreate = await context
                                          .read<TransaksiCubit>()
                                          .UpdateTransaksi(input);
                                      // var resultcreate = await CreateTransaksi(input);
                                      resultcreate.fold((error) {
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
                                      }, (right) async {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: const Text(
                                                    "Sukses Tambahkan Transaksi"),
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
                                      });
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
