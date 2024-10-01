import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/createCategory.dart';
import 'package:uas_flutter/helper/rupiah.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/pages/list-transaksi.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';

class AllTxApp extends StatefulWidget {
  AllTxApp({Key? key, this.restorationId}) : super(key: key);
  List<GetWalletModel> listWallet = [
    GetWalletModel(idWallet: 0, NamaWallet: " ", TotalSaldo: 0)
  ];
  List<GetTxModel> tagObjs = [
    GetTxModel(
      idTransaksi: 0,
      KeteranganTransaksi: "",
      idJenisTransaksi: 0,
      DebitKredit: "",
      nominal: 0,
      idUser: 0,
      idWallet: 0,
    ),
  ];
  String tanggal = "";
  final String? restorationId;
  List<GetJenisTransaksiModel>? listJenisTransaksi;
  GetJenisTransaksiModel? selectedjenisTransaksi;
  String? dropdownJenisTransaksiValue;

  GetWalletModel selectedlistWallet =
      GetWalletModel(idWallet: 0, NamaWallet: "", TotalSaldo: 1);
  List<String> listSort = ["Terbaru", "Terlama", "Terbesar", "Terkecil"];
  String selectedlistSort = "Terbaru";
  final RestorableDateTime _selectedDate = RestorableDateTime(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

  @override
  State<AllTxApp> createState() => AllTx();
}

class AllTx extends State<AllTxApp> with RestorationMixin {
  GetWallet() async {
    var getwallets = await GetWalletData("1", "10", "");
    setState(() {
      // widget.listWallet.clear();
      widget.listWallet = getwallets;
      // widget.dropdownWalletValue = getwallets.first.NamaWallet;
      widget.selectedlistWallet = getwallets.first;
      widget.listWallet.add(GetWalletModel(
          NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0));
    });
  }

  void initState() {
    super.initState();
    // widget.selectedlistWallet ??=
    //     GetWalletModel(idWallet: 0, NamaWallet: "New Wallet", TotalSaldo: 0);
    RecentTx();
    GetWallet();
    GetJenisTransaksi();
  }

  RecentTx() async {
    var gettxs = await GetTxData("", "", "");
    setState(() {
      widget.tagObjs = gettxs;
    });
  }

  GetJenisTransaksi() async {
    var getwallets = await GetJenisTransaksiData("");
    setState(() {
      widget.listJenisTransaksi = getwallets;
      widget.dropdownJenisTransaksiValue = getwallets.first.NamaJenisTransaksi;
      widget.listJenisTransaksi!.add(GetJenisTransaksiModel(
          NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0));
    });
  }

  @override
  String? get restorationId => widget.restorationId;
  RestorableDateTime get _selectedDate => widget._selectedDate;
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

  List<GetJenisTransaksiModel>? get listJenisTransaksi =>
      widget.listJenisTransaksi;
  GetJenisTransaksiModel? get selectedjenisTransaksi =>
      widget.selectedjenisTransaksi;
  String? get dropdownJenisTransaksiValue => widget.dropdownJenisTransaksiValue;
  List<GetTxModel> get tagObjs => widget.tagObjs;

  @override
  Widget build(BuildContext context) {
    print("abcd");
    if (_selectedDate.value.day != 0) {
      widget.tanggal =
          '${_selectedDate.value.year}/${_selectedDate.value.month}/${_selectedDate.value.day}';
    } else {
      widget.tanggal = "Pilih Tanggal";
    }
    return Scaffold(
        body: Container(
            width: 375,
            height: 891,
            decoration: const BoxDecoration(
              color: Color(0xffF5F7FF),
            ),
            child: Column(children: [
              const SizedBox(
                height: 44,
              ),
              Container(
                  height: 44,
                  child: Row(children: [
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: Transform.rotate(
                          angle: 180 * pi / 180,
                          child: SvgPicture.asset(
                            "assets/arrow_forward.svg",
                            width: 50,
                            height: 50,
                          ),
                        )),
                    const Center(
                        widthFactor: 3,
                        child: Text(
                          "All Transaksi",
                        ))
                  ])),
              Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                width: 355,
                height: 727,
                child: Column(
                  children: [
                    Container(
                      width: 335,
                      height: 37,
                      margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            child: SvgPicture.asset(
                              'assets/Logo.svg',
                              height: 18,
                              width: 18,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            width: 115,
                            height: 20,
                            child: DropdownButton<GetWalletModel>(
                              value: widget.selectedlistWallet,
                              underline: const SizedBox(),
                              items:
                                  widget.listWallet.map((GetWalletModel value) {
                                return new DropdownMenuItem<GetWalletModel>(
                                    value: value,
                                    child: new Wrap(children: [
                                      Text(value.NamaWallet),
                                    ]));
                              }).toList(),
                              onChanged: (GetWalletModel? value) {
                                setState(() {
                                  widget.selectedlistWallet = value!;
                                });
                                if (value!.NamaWallet == "Create Wallet") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateCategoriesApp()));
                                }
                              },
                              icon: Container(
                                // margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SvgPicture.asset(
                                  'assets/caret-arrow-up.svg',
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(36, 0, 0, 0),
                            child: Text("Urutkan:"),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                            width: 85,
                            height: 20,
                            child: DropdownButton<String>(
                              value: widget.selectedlistSort,
                              underline: const SizedBox(),
                              items: widget.listSort.map((String value) {
                                return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Wrap(children: [
                                      Text(value),
                                    ]));
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  widget.selectedlistSort = value!;
                                });
                                if (value! == "") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateCategoriesApp()));
                                }
                              },
                              icon: Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SvgPicture.asset(
                                  'assets/caret-arrow-up.svg',
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 339,
                      height: 80,
                      margin: const EdgeInsets.fromLTRB(20, 16, 12, 16),
                      child: Row(
                        children: [
                          Container(
                              width: 263,
                              height: 48,
                              child: Container(
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {
                                        _restorableDatePickerRouteFuture
                                            .present();
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Rentang Tanggal Transaksi",
                                              textAlign: TextAlign.left,
                                            ),
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 8),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            color: Color.fromRGBO(
                                                217, 217, 217, 1),
                                            child: Text(tanggal,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff3E3E3E),
                                                )),
                                          ),
                                        ],
                                      )))),
                          Container(
                              child: SvgPicture.asset(
                            'assets/Calendar.svg',
                            width: 18,
                            height: 20,
                          ))
                        ],
                      ),
                    ),
                    Container(
                      width: 339,
                      height: 85,
                      margin: const EdgeInsets.fromLTRB(20, 16, 12, 16),
                      child: Row(
                        children: [
                          Container(
                              width: 263,
                              height: 50,
                              child: Container(
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {},
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Kategori",
                                              textAlign: TextAlign.left,
                                            ),
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 8),
                                          ),
                                          Container(
                                              width: 283,
                                              height: 21,
                                              color: Color.fromRGBO(
                                                  217, 217, 217, 1),
                                              child: DropdownButton<
                                                      GetJenisTransaksiModel>(
                                                  underline: const SizedBox(),
                                                  value: selectedjenisTransaksi,
                                                  onChanged:
                                                      (GetJenisTransaksiModel?
                                                          value) {
                                                    setState(() {
                                                      widget.selectedjenisTransaksi =
                                                          value;
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  icon: Visibility(
                                                      visible: false,
                                                      child: Icon(Icons
                                                          .arrow_downward)),
                                                  items: widget
                                                      .listJenisTransaksi!
                                                      .map(
                                                          (GetJenisTransaksiModel
                                                              value) {
                                                    return new DropdownMenuItem<
                                                            GetJenisTransaksiModel>(
                                                        value: value,
                                                        child:
                                                            new Wrap(children: [
                                                          Text(value
                                                              .NamaJenisTransaksi),
                                                        ]));
                                                  }).toList())),
                                        ],
                                      )))),
                          Container(
                            margin: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                            child: SvgPicture.asset(
                              'assets/chevron-left.svg',
                              height: 16,
                              width: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // cardsmallZCp (117:2830)
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        // padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
                        width: 343,
                        height: 456,
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x3fe7e7e7),
                              offset: Offset(0, 4),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Container(
                          width: 343,
                          // frame1950dCg (117:2831)
                          // width: double.infinity,
                          // height: double.infinity,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: SizedBox(
                                      child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: tagObjs!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var transaksis = tagObjs?[index];
                                  // print(transaksis.data);
                                  // TODO:Getter model transaksi nya
                                  return ListTransaksiCard(
                                      transaksis!.KeteranganTransaksi,
                                      CurrencyFormat.convertToIdr(
                                          transaksis.nominal, 2),
                                      "",
                                      transaksis.idTransaksi);
                                },
                              )))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ])));
  }
}
