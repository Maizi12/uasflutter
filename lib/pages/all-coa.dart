import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/models/coa.dart';
import 'package:uas_flutter/models/kategori.dart';
import 'package:uas_flutter/pages/list-category-coa.dart';
import 'package:uas_flutter/pages/list-coa.dart';
import 'package:uas_flutter/view/category/createCategory.dart';
import 'package:uas_flutter/helper/rupiah.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/pages/list-transaksi.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

class AllCoaApp extends StatefulWidget {
  static const routeName = '/allcoa';

  AllCoaApp({super.key});

  @override
  State<AllCoaApp> createState() => AllCoa();
}

class AllCoa extends State<AllCoaApp> {
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
  List<GetCategoriesModel> jenisCoa = [
    GetCategoriesModel(idJenisCoa: 0, kodeJenisCoa: "", namaJenisCoa: ""),
  ];
  List<GetCategoriesAndSubModel> jenisCoaAndSub = [
    GetCategoriesAndSubModel(
      idJenisCoa: 0,
      kodeJenisCoa: "",
      namaJenisCoa: "",
      ListCoa: <GetCoaModel>[
        GetCoaModel(
            idJenisCoa: 0, idCoa: 0, kodeCoa: "", namaCoa: "", nominal: 0)
      ],
    ),
  ];
  List<GetCoaModel> ListCoa = [
    GetCoaModel(idCoa: 0, idJenisCoa: 0, kodeCoa: "", namaCoa: "", nominal: 0),
  ];
  String tanggal = "";
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
    GetCategories();
    // GetCoa();
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
        id: selectedlistWallet.idWallet,
        sort: selectedlistSort,
        idJenisTransaksi: selectedjenisTransaksi.idJenisTransaksi);
    gettxs.fold((failure) {}, (data) {
      setState(() {
        tagObjs = data;
      });
    });
  }

  GetCategories() async {
    final getcategories = await context.read<TransaksiCubit>().getCategories();
    getcategories.fold((failure) {}, (data) async {
      setState(() {
        jenisCoa = data;
      });
      jenisCoaAndSub.clear();
      for (var i = 0; i < jenisCoa.length; i++) {
        final getcoa =
            await context.read<TransaksiCubit>().getCoa(jenisCoa[i].idJenisCoa);
        getcoa.fold((failure) {}, (data) {
          setState(() {
            jenisCoaAndSub.add(GetCategoriesAndSubModel(
                idJenisCoa: jenisCoa[i].idJenisCoa,
                kodeJenisCoa: jenisCoa[i].kodeJenisCoa,
                namaJenisCoa: jenisCoa[i].namaJenisCoa,
                ListCoa: data));
          });
        });
      }
    });
  }

  GetJenisTransaksi() async {
    final gettxs = await context.read<TransaksiCubit>().getJenisTransaksi();
    gettxs.fold((failure) {}, (data) {
      setState(() {
        listJenisTransaksi.clear();
        listJenisTransaksi = [
          GetJenisTransaksiModel(
              NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0)
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
            body: Container(
                width: 375,
                // height: 8,
                // height: 85,
                decoration: const BoxDecoration(
                  color: Color(0xffF5F7FF),
                ),
                child: Column(children: [
                  const SizedBox(
                    height: 31,
                  ),
                  SizedBox(
                      height: 37,
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
                              "All Coa",
                            ))
                      ])),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    width: 355,
                    child: Column(
                      children: [
                        Container(
                          width: 343,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 17, 253),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                          child: Row(
                            children: [
                              Container(
                                  width: 300,
                                  height: 56,
                                  margin:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Container(
                                      child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () async {
                                            _selectDateRange(context);
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                child: const Text(
                                                  "Rentang Tanggal Transaksi",
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 244,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    margin: const EdgeInsets
                                                        .fromLTRB(0, 0, 20, 0),
                                                    // color: const Color.fromRGBO(
                                                    //     217, 217, 217, 1),
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
                                                  Container(
                                                      child: SvgPicture.asset(
                                                    'assets/Calendar.svg',
                                                    width: 18,
                                                    height: 20,
                                                  ))
                                                ],
                                              )
                                            ],
                                          )))),
                            ],
                          ),
                        ),
                        Container(
                          width: 343,
                          height: 85,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 17, 253),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                          child: Row(
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                  width: 263,
                                  height: 50,
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () async {},
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
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 17, 253),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x3fe7e7e7),
                                offset: Offset(0, 4),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: SizedBox(
                            width: 343,
                            child: Column(
                              children: <Widget>[
                                Flexible(
                                    child: CategoryList(
                                  categories: jenisCoaAndSub,
                                )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]))));
  }
}
