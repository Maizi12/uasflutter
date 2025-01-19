import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/view/category/createCategory.dart';
import 'package:uas_flutter/helper/rupiah.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/models/transaksi-go.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';
import 'package:uas_flutter/view/transaksi/transaksi2.dart';

class EditTransaksiApp extends StatefulWidget {
  EditTransaksiApp(
      {super.key,required this.IdTransaksi});
  int IdTransaksi;
  
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
  GetWalletModel selectedwallet=GetWalletModel(idWallet: 0, NamaWallet: "", TotalSaldo: 0);
  String? dropdownWalletValue;
   List<GetJenisTransaksiModel> listJenisTransaksi=[
GetJenisTransaksiModel(
          NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0)
  ];
 GetJenisTransaksiModel selectedjenisTransaksi=GetJenisTransaksiModel(
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
   if (_selectedDateRange.start.day!=0 || _selectedDateRange.end.day!=0){
          if (_selectedDateRange.start.day!=0 && _selectedDateRange.end.day!=0 ){
                tanggal ='${_selectedDateRange.start.day}/${_selectedDateRange.start.month}/${_selectedDateRange.start.year} - ${_selectedDateRange.end.day}/${_selectedDateRange.end.month}/${_selectedDateRange.end.year}';
          }else if(_selectedDateRange.start.day!=0){
            tanggal =
              '${_selectedDateRange.start.year}/${_selectedDateRange.start.month}/${_selectedDateRange.start.day}';
          }else{
          tanggal =
              '${_selectedDateRange.end.year}/${_selectedDateRange.end.month}/${_selectedDateRange.end.day}';
          }
        }else {
          tanggal = "Pilih Tanggal";
        }
    
  }
final DateTime now = DateTime.now();

  DateTimeRange _selectedDateRange=DateTimeRange(
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
         if (_selectedDateRange.start.day!=0 || _selectedDateRange.end.day!=0){
          if (_selectedDateRange.start.day!=0 && _selectedDateRange.end.day!=0 ){
                tanggal ='${_selectedDateRange.start.day}/${_selectedDateRange.start.month}/${_selectedDateRange.start.year} - ${_selectedDateRange.end.day}/${_selectedDateRange.end.month}/${_selectedDateRange.end.year}';
          }else if(_selectedDateRange.start.day!=0){
            tanggal =
              '${_selectedDateRange.start.year}/${_selectedDateRange.start.month}/${_selectedDateRange.start.day}';
          }else{
          tanggal =
              '${_selectedDateRange.end.year}/${_selectedDateRange.end.month}/${_selectedDateRange.end.day}';
          }
        }else {
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
    final gettxs= await context.read<TransaksiCubit>().getTxOne(id: widget.IdTransaksi.toString());
    gettxs.fold(
    (failure) {},
    (data) {
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
    if (tagObjs != null) {
      var selecttx = getwallets
          .where((wallet) => wallet.idWallet == tagObjs?.idWallet)
          .toList();
      setState(() {
        selectedwallet = selecttx.first;
        // selectedwallet ??= listWallet!.first;
// selectedjenisTransaksi ??= listJenisTransaksi!.first;

      });
    }
    setState(() {
      listWallet = getwallets;
      dropdownWalletValue = getwallets.first.NamaWallet;
      listWallet.add(GetWalletModel(
          NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0));
    });
  }

  GetJenisTransaksi() async {
       final getjenisTx= await context.read<TransaksiCubit>().getJenisTransaksi();
    getjenisTx.fold(
    (failure) {
    },
    (data) {
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
     listJenisTransaksi= [GetJenisTransaksiModel(NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0)];
    //  ,GetJenisTransaksiModel(NamaJenisTransaksi: "Select Kategori", idJenisTransaksi: 0)];
      listJenisTransaksi.addAll(data);
      dropdownJenisTransaksiValue = data.first.NamaJenisTransaksi;
      // listJenisTransaksi.add(GetJenisTransaksiModel(
          // NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0));
    });
    });
  }
  String? error;

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
        // Container(
        //   width: 343,
        //   height: 42,
        //   margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        //   child: Row(children: [
        //     Container(
        //         width: 165.5,
        //         height: 34,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(8),
        //           boxShadow: const [
        //             BoxShadow(
        //               color: Color.fromARGB(1, 245, 247, 255),
        //               offset: Offset(0, 2),
        //               blurRadius: 2,
        //             ),
        //           ],
        //         ),
        //         child: const Center(
        //           child: Text(
        //             "Kredit",
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //               fontFamily: 'Plus Jakarta Sans',
        //               fontSize: 14,
        //               fontWeight: FontWeight.w600,
        //             ),
        //           ),
        //         )),
        //     Container(
        //         width: 165.5,
        //         height: 34,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(8),
        //           boxShadow: const [
        //             BoxShadow(
        //               color: Color(0x0c000000),
        //               offset: Offset(0, 2),
        //               blurRadius: 2,
        //             ),
        //           ],
        //         ),
        //         child: const Center(
        //           child: Text(
        //             "Debit",
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //               fontFamily: 'Plus Jakarta Sans',
        //               fontSize: 14,
        //               fontWeight: FontWeight.w600,
        //             ),
        //           ),
        //         ))
        //   ]),
        // ),
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
                SizedBox(
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
                      SizedBox(
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
                                _selectDateRange(context);
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
                                    selectedjenisTransaksi = value!;
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
                                items: listJenisTransaksi
                                    .map((GetJenisTransaksiModel value) {
                                  return DropdownMenuItem<
                                          GetJenisTransaksiModel>(
                                      value: value,
                                      child: Wrap(children: [
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
                        SizedBox(
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
                                            selectedwallet = value!;
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
                                        items: listWallet!
                                            .map((GetWalletModel value) {
                                          return DropdownMenuItem<
                                                  GetWalletModel>(
                                              value: value,
                                              child: Wrap(children: [
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
                TimeOfDay currentTime = TimeOfDay.now();
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
                          selectedjenisTransaksi!.idJenisTransaksi,
                      tglTransaksi: tanggal,
                      waktuTransaksi: currentTime.format(context),
                      nominal: double.parse(nominalTransaksiController.text
                          .replaceAll(RegExp(r'(?:_|[^\w\s\r])+'), '')
                          // .replaceAll("IDR", '')
                          .replaceAll("Rp ", '')
                          .toString()),
                      idUser: 0,
                      idWallet: selectedwallet!.idWallet);
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
    ))));
  }
}
