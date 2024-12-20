import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_flutter/chart_bar.dart';
import 'package:uas_flutter/view/category/createCategory.dart';
import 'package:uas_flutter/view/login/cubit/auth_cubit.dart';
import 'package:uas_flutter/view/login/login.dart';
import 'package:uas_flutter/view/transaksi/createTransaksi.dart';
import 'package:uas_flutter/util/helper/helper.dart';
import 'package:uas_flutter/models/daysmodel/daysmodel.dart';
import 'package:uas_flutter/models/monthmodel/monthmodel.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/models/weekmodel/weekmodel.dart';
import 'package:uas_flutter/pages/all-tx.dart';
import 'package:uas_flutter/pages/footer.dart';
import 'package:uas_flutter/pages/list-transaksi.dart';
import 'package:uas_flutter/repositories/golang-repository.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';

class Transaksi2App extends StatefulWidget {
  static const routeName = '/transaksi';
  Transaksi2App({Key? key}) : super(key: key);
  // GetTx.GetTransaksi meta;
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
  int isHarian = 0;
  int isMingguan = 0;
  int isBulanan = 1;
  int isVisible = 1;
  List<GetWalletModel> listWallet = [
    GetWalletModel(idWallet: 1, NamaWallet: "Create Wallet1", TotalSaldo: 0)
  ];
  GetWalletModel selectedlistWallet =
      GetWalletModel(idWallet: 3, NamaWallet: "z", TotalSaldo: 1);
  GetBerandaModel getberanda = GetBerandaModel(
    totalDebit: 0,
    totalKredit: 0,
    totalSisa: 0,
    isget: 0,
    idWallet: 0,
    harian: List.empty(),
    pekanan: List.empty(),
    bulanan: List.empty(),
  );

  //  =
  //     GetWalletModel(idWallet: 0, NamaWallet: "Create Wallet", TotalSaldo: 0);
  // String dropdownWalletValue = " ";
  List<Map<String, Object>> _data1 = [
    {'name': 'Please wait', 'value': 0}
  ];
  @override
  State<Transaksi2App> createState() => Transaksi2();
}

class Transaksi2 extends State<Transaksi2App> {
  dynamic jsonlist;
  @override
  void initState() {
    super.initState();
    // widget.selectedlistWallet ??=
    //     GetWalletModel(idWallet: 0, NamaWallet: "New Wallet", TotalSaldo: 0);
    RecentTx();
    GetWallet();
    GetBeranda();
  }

  // GetTx.GetTransaksi? get meta => widget.meta;
  List<GetTxModel> get tagObjs => widget.tagObjs;
  // // String get dropdownWalletValue => widget.dropdownWalletValue;
  List<GetWalletModel> get listWallet => widget.listWallet;
  // GetWalletModel get selectedlistWallet => widget.selectedlistWallet;
  List<Map<String, Object>> get _data1 => widget._data1;
  RecentTx() async {
    var gettxs = await GetTxData("1", "10", "");
    setState(() {
      widget.tagObjs = gettxs;
    });
  }

  GetWallet() async {
    var getwallets = await GetWalletData("1", "10", "");
    setState(() {
      widget.listWallet.clear();
      widget.listWallet = getwallets;
      // widget.dropdownWalletValue = getwallets.first.NamaWallet;
      widget.selectedlistWallet = getwallets.first;
      widget.listWallet.add(GetWalletModel(
          NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0));
    });
    if (getwallets.isEmpty) {
      widget.listWallet = [
        GetWalletModel(
            idWallet: 2, NamaWallet: "Create Wallets", TotalSaldo: 0),
      ];
      GetWalletModel selectedlistWallet =
          GetWalletModel(idWallet: 3, NamaWallet: "z", TotalSaldo: 1);
    }
  }

  GetBeranda() async {
    GetBerandaModel getwallets;
    getwallets =
        await GetBerandaData(widget.selectedlistWallet!.idWallet); //testing
    if (widget.getberanda.isget == 0) {
      getwallets = await GetBerandaData(widget.selectedlistWallet!.idWallet);
    } else {
      getwallets = widget.getberanda;
    }
    if (widget.selectedlistWallet.idWallet != getwallets.idWallet) {
      getwallets = await GetBerandaData(widget.selectedlistWallet!.idWallet);
    }
    // print(widget.getberanda);
    // print(widget.getberanda.totalDebit);
    // print(widget.getberanda.totalKredit);
    // print(widget.getberanda.totalSisa);
    // print("widget.isHarian");
    // print(widget.isHarian);
    // print("widget.isBulanan");
    // print(widget.isBulanan);
    // print("widget.isMingguan");
    // print(widget.isMingguan);
    setState(() {
      if (widget.isHarian == 1) {
        widget._data1 = [];
      } else if (widget.isMingguan == 1) {
        widget._data1 = [];
      } else if (widget.isBulanan == 1) {
        widget._data1 = [];
      }
      widget.getberanda = getwallets;
    });
    print("widget._data1");
    print(widget._data1);
  }

  String? error;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
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
              height: 891,
              decoration: const BoxDecoration(
                color: Color(0xffF5F7FF),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 44,
                  ),
                  Container(
                      width: 375,
                      height: 50,
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(children: [
                        Container(
                          width: 375,
                          height: 27,
                          margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                width: 30,
                                height: 30,
                                child: SvgPicture.asset(
                                  'assets/Logo.svg',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                width: 130,
                                height: 30,
                                child: Container(),
                                // DropdownButton<GetWalletModel>(
                                //   value: widget.selectedlistWallet,
                                //   underline: const SizedBox(),
                                //   items: widget.listWallet
                                //       .map((GetWalletModel values) {
                                //     return DropdownMenuItem<GetWalletModel>(
                                //         value: values,
                                //         child: Wrap(children: [
                                //           Text(values.NamaWallet),
                                //         ]));
                                //   }).toList(),
                                //   onChanged: (GetWalletModel? value) {
                                //     setState(() {
                                //       widget.selectedlistWallet = value!;
                                //       GetBeranda();
                                //     });
                                //     if (value!.NamaWallet == "Create Wallet") {
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (context) =>
                                //                   const CreateCategoriesApp()));
                                //     }
                                //   },
                                //   icon: Container(
                                //     margin:
                                //         const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                //     child: SvgPicture.asset(
                                //       'assets/caret-arrow-up.svg',
                                //       height: 16,
                                //       width: 16,
                                //     ),
                                //   ),
                                //   padding:
                                //       const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                // ),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Container(
                                width: 90,
                                height: 100,
                                child: SvgPicture.asset(
                                  'assets/notif.svg',
                                  height: 40,
                                  width: 40,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // width: 200,
                          // height: 18,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Keuangan Kamu Terlihat Sehat",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.26,
                              color: Color(0xff5C616F),
                            ),
                          ),
                        ),
                      ])),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    width: 343,
                    height: 103,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 17, 253),
                        width: 2.0,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3fe7e7e7),
                          offset: Offset(0, 4),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(children: [
                      Container(
                        width: 330,
                        height: 14,
                        margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: const Text(
                                "Dari",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff131313),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 160,
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              width: 30,
                              height: 30,
                              child: SvgPicture.asset(
                                'assets/Logo.svg',
                                height: 30,
                                width: 30,
                              ),
                            ),
                            Container(
                              width: 80,
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: const Text(
                                "Dompet Saya",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff131313),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 256,
                        height: 49,
                        margin: const EdgeInsets.fromLTRB(16, 12, 141, 16),
                        child: Column(children: [
                          Container(
                            width: 101,
                            height: 13,
                            margin: const EdgeInsets.fromLTRB(0, 0, 85, 8),
                            child: const Text(
                              "Total Saldo",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff5C616F),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 195,
                            height: 28,
                            // margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 127,
                                    height: 28,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: const Text(
                                      "Rp 5,200,00",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff161719),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        if (widget.isVisible == 1) {
                                          widget.isVisible = 0;
                                          String textsaldo;
                                          textsaldo = "Rp 5,200,000";
                                        } else {
                                          widget.isVisible = 1;
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 6, 0, 6),
                                        width: 24,
                                        height: 16,
                                        child: SvgPicture.asset(
                                          'assets/eye.svg',
                                          height: 16,
                                          width: 16,
                                        ),
                                      ))
                                ]),
                          )
                        ]),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                      width: 375,
                      height: 20,
                      margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Laporan Pengeluaran",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff161719),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                          ),
                        ],
                      )),
                  Container(
                    width: 343,
                    height: 304,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 17, 253),
                        width: 2.0,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 255, 255),
                          offset: Offset(0, 4),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(children: [
                      Container(
                        width: 311,
                        height: 42,
                        margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                setState(() {
                                  widget.isHarian = 1;
                                  widget.isMingguan = 0;
                                  widget.isBulanan = 0;
                                });
                                GetBeranda();
                              },
                              child: Container(
                                width: 98,
                                height: 34,
                                margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
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
                                    'Harian',
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
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                setState(() {
                                  widget.isHarian = 0;
                                  widget.isMingguan = 1;
                                  widget.isBulanan = 0;
                                });
                                GetBeranda();
                              },
                              child: Container(
                                width: 98,
                                height: 34,
                                margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
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
                                    'Mingguan',
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
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                setState(() {
                                  widget.isHarian = 0;
                                  widget.isMingguan = 0;
                                  widget.isBulanan = 1;
                                });
                                GetBeranda();
                              },
                              child: Container(
                                width: 99,
                                height: 34,
                                margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x0c000000),
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Bulanan',
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
                      Container(
                        height: 242,
                        width: double.infinity,
                        child: BarChartSample4(
                          getberanda: widget.getberanda,
                          isBulanan: widget.isBulanan,
                          isHarian: widget.isHarian,
                          isMingguan: widget.isMingguan,
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    width: 343,
                    height: 20,
                    margin: const EdgeInsets.fromLTRB(16, 10, 0, 10),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          height: 20,
                          margin: const EdgeInsets.fromLTRB(0, 1.5, 96, 1.5),
                          child: const Text(
                            "Transaksi Terbaru",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff5C616F),
                            ),
                          ),
                        ),
                        GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllTxApp()));
                            },
                            child: Container(
                                width: 86,
                                height: 17,
                                child: Row(children: [
                                  Text(
                                    "Lihat Semua",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff2C14DD),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: SvgPicture.asset(
                                      "assets/arrow_forward.svg",
                                      width: 16,
                                      height: 16,
                                    ),
                                  )
                                ])))
                      ],
                    ),
                  ),
                  Container(
                    // cardsmallZCp (117:2830)
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      // padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
                      width: 343,
                      height: 130,
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
              )),
          floatingActionButton: SizedBox(
              height: 40,
              width: 40,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 30, 0, 255),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateTransaksiApp()));
                  },
                  elevation: 12,
                  child: Container(
                      child: SvgPicture.asset("assets/plus-white.svg")),
                  //TOOD:ini belum floating button
                ),
              )),
          bottomNavigationBar: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                  width: 390,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: const FooterCard())),
        ));
  }
}
