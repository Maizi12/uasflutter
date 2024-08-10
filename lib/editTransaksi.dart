import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/createCategory.dart';
import 'package:uas_flutter/domain/bloc/transaksi/transaksi_bloc.dart';
import 'package:uas_flutter/helper/rupiah.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/models/transaksi-go.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';
import 'package:uas_flutter/transaksi2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTransaksiApp extends StatefulWidget {
  EditTransaksiApp(
      {super.key, this.restorationId, required this.IdTransaksi, this.tagObjs});
  GetTxModel? tagObjs;
  int IdTransaksi;
  List<GetWalletModel>? listWallet;
  GetWalletModel? selectedwallet;
  String? dropdownWalletValue;
  List<GetJenisTransaksiModel>? listJenisTransaksi;
  GetJenisTransaksiModel? selectedjenisTransaksi;
  final String? restorationId;
  String tanggal = "";
  String? dropdownJenisTransaksiValue;
  final RestorableDateTime _selectedDate = RestorableDateTime(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  @override
  State<EditTransaksiApp> createState() => EditTransaksi();
}

TextEditingController namaTransaksiController = TextEditingController();
TextEditingController nominalTransaksiController = TextEditingController();
TextEditingController tanggalTransaksiController = TextEditingController();
TextEditingController kategori = TextEditingController();
TextEditingController dompetTransaksiController = TextEditingController();

class EditTransaksi extends State<EditTransaksiApp> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;
  RestorableDateTime get _selectedDate => widget._selectedDate;
  bool _validatenama = false;
  bool _validatenominal = false;

  String get tanggal => widget.tanggal;
  // final RestorableDateTime _selectedDate = RestorableDateTime(
  //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(DateTime.now().year + 1),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  String? get dropdownWalletValue => widget.dropdownWalletValue;
  List<GetWalletModel>? get listWallet => widget.listWallet;
  GetWalletModel? get selectedwallet => widget.selectedwallet;

  String? get dropdownJenisTransaksiValue => widget.dropdownJenisTransaksiValue;
  List<GetJenisTransaksiModel>? get listJenisTransaksi =>
      widget.listJenisTransaksi;
  GetJenisTransaksiModel? get selectedjenisTransaksi =>
      widget.selectedjenisTransaksi;
  @override
  void initState() {
    super.initState();
    RecentTx();
    GetWallets();
    GetJenisTransaksi();
  }

  GetData() async {
    GetWallets();
    RecentTx();
    GetJenisTransaksi();
  }

  GetTxModel? get tagObjs => widget.tagObjs;
  RecentTx() async {
    print("widget.IdTransaksi");
    print(widget.IdTransaksi);
    var gettxs = await GetTxOne("", "", widget.IdTransaksi.toString());
    setState(() {
      nominalTransaksiController.text =
          CurrencyFormat.convertToIdr(gettxs.nominal, 0);
      namaTransaksiController.text = gettxs.KeteranganTransaksi;
      widget.tagObjs = gettxs;
    });
    print("widget.tagObjs");
    print(widget.tagObjs);
  }

  GetWallets() async {
    var getwallets = await GetWalletData("1", "10", "");
    if (tagObjs != null) {
      var selecttx = getwallets
          .where((wallet) => wallet.idWallet == tagObjs?.idWallet)
          .toList();
      setState(() {
        widget.selectedwallet = selecttx.first;
      });
    }
    setState(() {
      widget.listWallet = getwallets;
      widget.dropdownWalletValue = getwallets.first.NamaWallet;
      widget.listWallet!.add(GetWalletModel(
          NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0));
    });
  }

  GetJenisTransaksi() async {
    var getjenisTx = await GetJenisTransaksiData("");
    if (tagObjs != null) {
      var selecttx = getjenisTx
          .where((jenistx) =>
              jenistx.idJenisTransaksi == tagObjs?.idJenisTransaksi)
          .toList();
      setState(() {
        widget.selectedjenisTransaksi = selecttx.first;
      });
    }
    setState(() {
      widget.listJenisTransaksi = getjenisTx;
      widget.dropdownJenisTransaksiValue = getjenisTx.first.NamaJenisTransaksi;
      widget.listJenisTransaksi!.add(GetJenisTransaksiModel(
          NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0));
    });
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedDate.value.day != 0) {
      widget.tanggal =
          '${_selectedDate.value.year}/${_selectedDate.value.month}/${_selectedDate.value.day}';
    } else {
      widget.tanggal = "Pilih Tanggal";
    }
    widget.selectedwallet ??= listWallet!.first;
    widget.selectedjenisTransaksi ??= listJenisTransaksi!.first;
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
                      if (context.mounted) Navigator.of(context).pop();
                    },
                  )),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 20, 0, 0),
                width: 125,
                height: 24,
                child: const Text(
                  'Edit Transaksi',
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
        const SizedBox(
          height: 24,
        ),
        Container(
          width: 343,
          height: 42,
          margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Row(children: [
            Container(
                width: 165.5,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(1, 245, 247, 255),
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Pengeluaran",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
            Container(
                width: 165.5,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0c000000),
                      offset: Offset(0, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Pemasukan",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ))
          ]),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          width: 335,
          height: 575,
          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
              margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Row(children: [
                Container(
                  width: 335,
                  // margin: const EdgeInsets.fromLTRB(104, 0, 0, 0),
                  child: TextFormField(
                    // text"0",
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
                          locale: "id-ID", decimalDigits: 0, symbol: "Rp ")
                    ],
                  ),
                ),
              ]),
            ),
            const Divider(thickness: 1, color: Colors.black),
            SizedBox(
              width: 335,
              height: 33,
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
                                    CurrencyFormat.convertToIdr(100000, 2);
                              });
                            },
                            child: Text(
                              "Rp 100,000",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 44, 20, 221)),
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
              width: 375,
              height: 80,
              margin: const EdgeInsets.fromLTRB(10, 24, 10, 0),
              child: SizedBox(
                width: 315,
                height: 55,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Nama Transaksi"),
                      Container(
                        width: 315,
                        height: 40,
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
              width: 375,
              height: 55,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(children: [
                SizedBox(
                  width: 295,
                  height: 50,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text("Tanggal Transaksi",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff5C616F))),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                            child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  _restorableDatePickerRouteFuture.present();
                                },
                                child: Row(
                                  children: [
                                    Text(tanggal,
                                        style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff3E3E3E))),
                                    Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            185, 0, 0, 0),
                                        child: SvgPicture.asset(
                                          'assets/Calendar.svg',
                                          width: 18,
                                          height: 20,
                                        ))
                                  ],
                                ))),
                      ]),
                ),
              ]),
            ),
            Container(
              width: 375,
              height: 71,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(children: [
                SizedBox(
                  width: 315,
                  height: 70,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text("Pilih Kategori",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff5C616F))),
                        ),
                        Container(
                            child: DropdownButton<GetJenisTransaksiModel>(
                                underline: const SizedBox(),
                                value: selectedjenisTransaksi,
                                onChanged: (GetJenisTransaksiModel? value) {
                                  setState(() {
                                    widget.selectedjenisTransaksi = value;
                                  });
                                  if (dropdownJenisTransaksiValue ==
                                      "Create Kategori") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CreateCategoriesApp()));
                                  }
                                },
                                icon: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(185, 0, 0, 0),
                                  child: SvgPicture.asset(
                                    'assets/chevron-left.svg',
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                items: widget.listJenisTransaksi!
                                    .map((GetJenisTransaksiModel value) {
                                  return new DropdownMenuItem<
                                          GetJenisTransaksiModel>(
                                      value: value,
                                      child: new Wrap(children: [
                                        Text(value.NamaJenisTransaksi),
                                      ]));
                                }).toList())),
                      ]),
                ),
              ]),
            ),
            Container(
              width: 375,
              height: 71,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(children: [
                SizedBox(
                  width: 315,
                  height: 50,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text("Pilih Dompet",
                              style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff5C616F))),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                            height: 20,
                            child: Row(
                              children: [
                                Container(
                                  // frame204Jp (116:2555)
                                  margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  width: 18,
                                  height: 18,
                                  child: SvgPicture.asset(
                                    'assets/Logo.svg',
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                                Container(
                                    child: DropdownButton<GetWalletModel>(
                                        underline: const SizedBox(),
                                        value: selectedwallet,
                                        onChanged: (GetWalletModel? value) {
                                          setState(() {
                                            widget.selectedwallet = value;
                                          });
                                          if (dropdownWalletValue ==
                                              "Create Wallet") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CreateCategoriesApp()));
                                          }
                                        },
                                        icon: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              15, 0, 0, 0),
                                          child: SvgPicture.asset(
                                            'assets/chevron-left.svg',
                                            height: 16,
                                            width: 16,
                                          ),
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        items: widget.listWallet!
                                            .map((GetWalletModel value) {
                                          return new DropdownMenuItem<
                                                  GetWalletModel>(
                                              value: value,
                                              child: new Wrap(children: [
                                                Text(value.NamaWallet),
                                                Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        50, 0, 0, 0),
                                                    child: Text(
                                                        CurrencyFormat
                                                            .convertToIdr(
                                                                value
                                                                    .TotalSaldo,
                                                                2),
                                                        textAlign:
                                                            TextAlign.right))
                                              ]));
                                        }).toList())),
                              ],
                            )),
                      ]),
                ),
              ]),
            )
          ]),
        ),
        Container(
          width: 335,
          height: 48,
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          decoration: BoxDecoration(
            color: const Color(0xff2c14dd),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Center(
                child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                TimeOfDay _currentTime = TimeOfDay.now();
                setState(() {
                  _validatenominal = nominalTransaksiController.text.isEmpty;
                  _validatenama = namaTransaksiController.text.isEmpty;
                });
                // var nominals = nominalTransaksiController.text
                //     .replaceAll(RegExp(r'(?:_|[^\w\s\r])+'), '')
                //     .replaceAll("IDR", '');
                // print("nominals");
                // print(nominals);
                if (!_validatenama && !_validatenominal) {
                  TransaksiGo input = TransaksiGo(
                      idTransaksi: widget.IdTransaksi,
                      keteranganTransaksi: namaTransaksiController.text,
                      idJenisTransaksi:
                          widget.selectedjenisTransaksi!.idJenisTransaksi,
                      tglTransaksi: tanggal,
                      waktuTransaksi: "${_currentTime.format(context)}",
                      nominal: double.parse(nominalTransaksiController.text
                          .replaceAll(RegExp(r'(?:_|[^\w\s\r])+'), '')
                          // .replaceAll("IDR", '')
                          .replaceAll("Rp ", '')
                          .toString()),
                      idUser: 0,
                      idWallet: widget.selectedwallet!.idWallet);
                  var resultcreate =
                      await TransaksiRepository().CreateTransaksi(input);
                  if (resultcreate.code != "200") {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text("Gagal Tambahkan Transaksi"),
                            // content: Text("tokennya$token"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                  );
                                },
                                child: const Text("Kembali"),
                              )
                            ]);
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text("Sukses Tambahkan Transaksi"),
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
                                child: const Text("Dashboard"),
                              )
                            ]);
                      },
                    );
                  }
                }
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Transaksi2App()));
              },
              child: const Text(
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
        ),
      ]),
    )));
  }
}
