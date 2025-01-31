import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/pages/header.dart';
import 'package:uas_flutter/view/category/createCategory.dart';
import 'package:uas_flutter/helper/rupiah.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/pages/list-transaksi.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

class AllTxApp extends StatefulWidget {
  static const routeName = '/alltx';

  AllTxApp({super.key});

  @override
  State<AllTxApp> createState() => AllTx();
}

class AllTx extends State<AllTxApp> {
  List<GetWalletModel> listWallet = [
    GetWalletModel(idWallet: 0, NamaWallet: " ", TotalSaldo: 0)
  ];
  List<GetTxModel> tagObjs = [
    GetTxModel(
      idTransaksi: 0,
      KeteranganTransaksi: "",
      idJenisTransaksi: 0,
      DebitKredit: "",
      WaktuTransaksi: "",
      nominal: 0,
      idUser: 0,
      idCoa: 0,
      TanggalTransaksi: "",
    ),
  ];
  String tanggal = "Pilih Tanggal";
  List<GetJenisTransaksiModel> listJenisTransaksi = [
    GetJenisTransaksiModel(
        NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0)
  ];

  GetJenisTransaksiModel selectedjenisTransaksi = GetJenisTransaksiModel(
      NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0);
  String? dropdownJenisTransaksiValue;
  GetWalletModel selectedlistWallet =
      GetWalletModel(idWallet: 0, NamaWallet: "", TotalSaldo: 1);
  List<String> listSort = ["Terbaru", "Terlama", "Terbesar", "Terkecil"];
  String selectedlistSort = "Terbaru";
  List<int> listSortTampil = [10, 20, 50, 100];
  int selectedlistSortTampil = 10;
  final RestorableDateTime _selectedDate = RestorableDateTime(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

  GetWallet() async {
    var getwallets = GetWalletDataStorage();
    // var getwallets = await GetWalletData("1", "10", "");
    setState(() {
      // listWallet.clear();
      listWallet = getwallets;
      // dropdownWalletValue = getwallets.first.NamaWallet;
      selectedlistWallet = getwallets.first;
      listWallet.add(GetWalletModel(
          NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0));
    });
  }

  @override
  void initState() {
    super.initState();
    GetWallet();
    GetJenisTransaksi();
    RecentTx();
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

  RecentTx() async {
    final gettxs = await context.read<TransaksiCubit>().getRecentTx(
        page: "1",
        idWallet: selectedlistWallet.idWallet,
        sort: selectedlistSort,
        idJenisTransaksi: selectedjenisTransaksi.idJenisTransaksi,
        tglAwal:
            '${_selectedDateRange.start.year}-${_selectedDateRange.start.month}-${_selectedDateRange.start.day}',
        tglAkhir:
            '${_selectedDateRange.end.year}-${_selectedDateRange.end.month}-${_selectedDateRange.end.day}');
    gettxs.fold((failure) {}, (data) {
      setState(() {
        tagObjs = data;
      });
    });
  }

  GetJenisTransaksi() async {
    final gettxs = await context.read<TransaksiCubit>().getJenisTransaksi();
    gettxs.fold((failure) {}, (data) {
      setState(() {
        listJenisTransaksi.clear();
        listJenisTransaksi = [
          GetJenisTransaksiModel(
              NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0),
          GetJenisTransaksiModel(
              NamaJenisTransaksi: "Select Kategori", idJenisTransaksi: 0)
        ];
        selectedjenisTransaksi = listJenisTransaksi.first;
        listJenisTransaksi.addAll(data);
        dropdownJenisTransaksiValue = data.first.NamaJenisTransaksi;
      });
    });
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

  String? error;

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
            appBar: HeaderCard(namaMenu: "All Transaksi"),
            body: Container(
                width: 375,
                // height: 8,
                // height: 85,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 245, 247, 255),
                ),
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    width: 355,
                    child: Column(
                      children: [
                        Container(
                          width: 335,
                          height: 37,
                          // margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
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
                                  value: selectedlistWallet,
                                  underline: const SizedBox(),
                                  items: listWallet.map((GetWalletModel value) {
                                    return DropdownMenuItem<GetWalletModel>(
                                        value: value,
                                        child: Wrap(children: [
                                          Text(value.NamaWallet),
                                        ]));
                                  }).toList(),
                                  onChanged: (GetWalletModel? value) {
                                    setState(() {
                                      selectedlistWallet = value!;
                                      RecentTx();
                                      // GetJenisTransaksi();
                                    });
                                    if (value!.NamaWallet == "Create Wallet") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CreateCategoriesApp()));
                                    }
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/caret-arrow-up.svg',
                                    height: 16,
                                    width: 16,
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(36, 0, 0, 0),
                                child: const Text("Urutkan:"),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                                width: 85,
                                height: 20,
                                child: DropdownButton<String>(
                                  value: selectedlistSort,
                                  underline: const SizedBox(),
                                  items: listSort.map((String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Wrap(children: [
                                          Text(value),
                                        ]));
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedlistSort = value!;
                                      RecentTx();
                                      if (selectedlistSort == "Terbaru") {
                                        tagObjs.sort((a, b) =>
                                            a.WaktuTransaksi.compareTo(
                                                b.WaktuTransaksi));
                                      } else {
                                        tagObjs.sort((a, b) =>
                                            a.WaktuTransaksi.compareTo(
                                                b.WaktuTransaksi));
                                      }
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
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                        // Container(
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         margin: const EdgeInsets.fromLTRB(170, 0, 0, 0),
                        //         child: const Text("Tampilkan:"),
                        //       ),
                        //       Container(
                        //         margin: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                        //         width: 85,
                        //         height: 20,
                        //         child: DropdownButton<int>(
                        //           value: selectedlistSortTampil,
                        //           underline: const SizedBox(),
                        //           items: listSortTampil.map((int value) {
                        //             return DropdownMenuItem<int>(
                        //                 value: value,
                        //                 child: Wrap(children: [
                        //                   Text(value.toString()),
                        //                 ]));
                        //           }).toList(),
                        //           onChanged: (int? value) {
                        //             setState(() {
                        //               selectedlistSortTampil = value!;
                        //             });
                        //             if (value! == 0) {
                        //               // Navigator.push(
                        //               //     context,
                        //               //     MaterialPageRoute(
                        //               //         builder: (context) =>
                        //               //             const CreateCategoriesApp()));
                        //             }
                        //           },
                        //           icon: Container(
                        //             margin:
                        //                 const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        //             child: SvgPicture.asset(
                        //               'assets/caret-arrow-up.svg',
                        //               height: 16,
                        //               width: 16,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
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
                            // border: Border.all(
                            //   color: const Color.fromARGB(255, 0, 17, 253),
                            //   width: 2.0,
                            // ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                          child: Row(
                            children: [
                              Container(
                                  width: 300,
                                  height: 56,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Container(
                                      width: 345,
                                      margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
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
                                                    width: 180,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    margin: EdgeInsets.fromLTRB(
                                                        20, 0, 0, 0),
                                                    child: const Text(
                                                      "Rentang Tanggal Transaksi",
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Container(
                                                    width: 170,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    // color: const Color.fromRGBO(
                                                    //     217, 217, 217, 1),
                                                    margin: EdgeInsets.fromLTRB(
                                                        20, 0, 0, 0),
                                                    child: Text(tanggal,
                                                        textAlign:
                                                            TextAlign.center,
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
                            ],
                          ),
                        ),
                        Container(
                          width: 343,
                          height: 85,
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
                            // border: Border.all(
                            //   color: const Color.fromARGB(255, 0, 17, 253),
                            //   width: 2.0,
                            // ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                          child: Row(
                            children: [
                              GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {},
                                  child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          30, 0, 30, 0),
                                      width: 263,
                                      height: 50,
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: const Text(
                                              "Kategori",
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          SizedBox(
                                              width: 283,
                                              height: 21,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    // color: const Color.fromRGBO(
                                                    //     217, 217, 217, 1),
                                                    width: 140,
                                                    child: DropdownButton<
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
                                                  const SizedBox(
                                                    width: 100,
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 0),
                                                    child: SvgPicture.asset(
                                                      'assets/chevron-left.svg',
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ))),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          // padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
                          width: 343,
                          height: 456,

                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0c000000),
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: SizedBox(
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
                                  itemCount:
                                      (selectedlistSortTampil >= tagObjs.length
                                          ? tagObjs.length
                                          : selectedlistSortTampil),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var transaksis = tagObjs[index];
                                    // print(transaksis.data);
                                    // TODO:Getter model transaksi nya
                                    return ListTransaksiCard(
                                        transaksis.KeteranganTransaksi,
                                        CurrencyFormat.convertToIdr(
                                            transaksis.nominal, 2),
                                        "",
                                        transaksis.idTransaksi,
                                        transaksis.TanggalTransaksi);
                                  },
                                )))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]))));
  }
}
