import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/chart_bar.dart';
import 'package:uas_flutter/pages/new-multi-tx.dart';
import 'package:uas_flutter/view/category/createCategory.dart';
import 'package:uas_flutter/view/transaksi/createTransaksi.dart';
import 'package:uas_flutter/util/helper/helper.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/pages/all-tx.dart';
import 'package:uas_flutter/pages/footer.dart';
import 'package:uas_flutter/pages/list-transaksi.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

class Transaksi2App extends StatefulWidget {
  static const routeName = '/transaksi';
  const Transaksi2App({super.key});
  // GetTx.GetTransaksi meta;

  @override
  State<Transaksi2App> createState() => Transaksi2();
}

class Transaksi2 extends State<Transaksi2App> {
  dynamic jsonlist;
  String NamaMenu = "Overview";
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
        TanggalTransaksi: ""),
  ];
  int isHarian = 0;
  int isMingguan = 0;
  int isBulanan = 1;
  int isVisible = 1;
  String textsaldo = "";
  List<GetWalletModel> listWallet = [
    GetWalletModel(idWallet: 0, NamaWallet: "Create Wallet", TotalSaldo: 0)
  ];
  GetWalletModel selectedlistWallet =
      GetWalletModel(NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0);
  GetBerandaModel getberanda = GetBerandaModel(
    totalDebit: 0,
    totalKredit: 0,
    totalSisa: 0,
    isget: 0,
    idCoa: 0,
    harian: List.empty(),
    pekanan: List.empty(),
    bulanan: List.empty(),
  );

  bool _isFirstLoad = true;
  @override
  void initState() {
    super.initState();
    if (_isFirstLoad) {
      context.read<TransaksiCubit>().getWallet();
      RecentTx();
      GetWallet();
      GetBeranda();
      _isFirstLoad = true;
    }
  }

  RecentTx() async {
    // var gettxs = await GetTxData("1", "10", "");
    final gettxs = await context.read<TransaksiCubit>().getRecentTx(
        page: "1",
        pageSize: "",
        id: "0",
        idWallet: selectedlistWallet.idWallet);
    // final result=await cubit.getBeranda(idWallet: selectedlistWallet.idWallet);
    gettxs.fold((failure) {
      // print('Error: ${failure.toString()}');
    }, (data) {
      setState(() {
        tagObjs = data;
      });
    });
  }

  GetWallet() async {
    var getwall = GetWalletDataStorage();
    setState(() {
      if (getwall.isNotEmpty) {
        listWallet.clear();
        selectedlistWallet = getwall.first; //harus array first kayaknya
        listWallet.addAll(getwall);
        listWallet.add(GetWalletModel(
            NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0));
      }
    });
    if (getwall.isEmpty) {
      listWallet.clear();
      listWallet = [
        GetWalletModel(
            idWallet: 2, NamaWallet: "Create Wallets", TotalSaldo: 1),
      ];
    }
  }

  GetBeranda() async {
    final cubit = context.read<TransaksiCubit>();
    GetBerandaModel getberandas;
    if (getberanda.isget == 0 ||
        selectedlistWallet.idWallet != getberanda.idCoa) {
      final result =
          await cubit.getBeranda(idWallet: selectedlistWallet.idWallet);
      result.fold(
        (failure) {
          // print('Error: ${failure.toString()}');
        },
        (data) {
          // print('Data received: ${data}');
          getberandas = data;
          setState(() {
            getberanda = getberandas;
          });
        },
      );
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
              height: 920,
              decoration: const BoxDecoration(
                color: Color(0xffF5F7FF),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: 375,
                      height: 68,
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
                                child:
                                    // Container(),
                                    DropdownButton<GetWalletModel>(
                                  value: selectedlistWallet,
                                  underline: const SizedBox(),
                                  items:
                                      listWallet.map((GetWalletModel values) {
                                    return DropdownMenuItem<GetWalletModel>(
                                        value: values,
                                        child: Wrap(children: [
                                          Text(values.NamaWallet),
                                        ]));
                                  }).toList(),
                                  onChanged: (GetWalletModel? value) {
                                    setState(() {
                                      selectedlistWallet = value!;
                                      GetBeranda();
                                      RecentTx();
                                      if (isVisible == 1) {
                                        textsaldo = "";
                                      } else {
                                        textsaldo = CurrencyFormat.convertToIdr(
                                            selectedlistWallet.TotalSaldo, 2);
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
                                  icon: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: SvgPicture.asset(
                                      'assets/caret-arrow-up.svg',
                                      height: 16,
                                      width: 16,
                                    ),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                ),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              SizedBox(
                                width: 40,
                                height: 40,
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
                          margin: const EdgeInsets.fromLTRB(
                              0, 5, 0, 0), // width: 200,
                          height: 26,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Keuangan Kamu Terlihat Sehat",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
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
                          color: Color.fromARGB(5, 17, 20, 177),
                          offset: Offset(0, 3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(children: [
                      Container(
                        width: 400,
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
                        width: 400,
                        height: 49,
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(16, 12, 50, 16),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 258,
                                      height: 13,
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 8),
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
                                      width: 258,
                                      height: 28,
                                      child: Row(children: [
                                        Container(
                                          width: 200,
                                          height: 28,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 8, 0),
                                          child: Text(
                                            textsaldo,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
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
                                              setState(() {
                                                if (isVisible == 1) {
                                                  isVisible = 0;
                                                  textsaldo = CurrencyFormat
                                                      .convertToIdr(
                                                          selectedlistWallet
                                                              .TotalSaldo,
                                                          2);
                                                } else {
                                                  isVisible = 1;
                                                  textsaldo = "";
                                                }
                                              });
                                            },
                                            child: SizedBox(
                                              // padding: EdgeInsets.fromLTRB(10, 6, 0, 6),
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
                                  ])
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
                        ],
                      )),
                  Container(
                    width: 343,
                    height: 304,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(5, 17, 20, 177),
                          offset: Offset(0, 3),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Column(children: [
                      Container(
                        width: 311,
                        height: 42,
                        margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 242, 244, 245),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                setState(() {
                                  isHarian = 1;
                                  isMingguan = 0;
                                  isBulanan = 0;
                                });
                                GetBeranda();
                              },
                              child: Container(
                                width: 98,
                                height: 34,
                                margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: isHarian == 1
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : null,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(5, 0, 0, 0),
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
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
                                  isHarian = 0;
                                  isMingguan = 1;
                                  isBulanan = 0;
                                  print("isMingguan");
                                  print(isMingguan);
                                });
                                GetBeranda();
                              },
                              child: Container(
                                width: 98,
                                height: 34,
                                margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: isMingguan == 1
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : null,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(5, 0, 0, 0),
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
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
                                  isHarian = 0;
                                  isMingguan = 0;
                                  isBulanan = 1;
                                });
                                GetBeranda();
                              },
                              child: Container(
                                width: 99,
                                height: 34,
                                margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                decoration: BoxDecoration(
                                  color: isBulanan == 1
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : null,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(5, 0, 0, 0),
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
                      SizedBox(
                        height: 242,
                        width: double.infinity,
                        child: BarChartSample4(
                          getberanda: getberanda,
                          isBulanan: isBulanan,
                          isHarian: isHarian,
                          isMingguan: isMingguan,
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
                          margin: const EdgeInsets.fromLTRB(0, 1.5, 120, 1.5),
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
                            child: SizedBox(
                                width: 86,
                                height: 17,
                                child: Row(children: [
                                  const Text(
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
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 5),
                    // cardsmallZCp (117:2830)
                    child: Container(
                      // margin: EdgeInsets.fromLTRB(16, 0, 0, 5),
                      // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      width: 340,
                      height: 136,
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
                            color: Color.fromARGB(5, 17, 20, 177),
                            offset: Offset(0, 3),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: 330,
                        // frame1950dCg (117:2831)
                        // width: double.infinity,
                        // height: double.infinity,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                // flex: 2,
                                child: SizedBox(
                                    child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: tagObjs.length,
                              itemBuilder: (BuildContext context, int index) {
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
                            builder: (context) => CreateMultiTransaksiApp()));
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
                  child: FooterCard(
                    namaMenu: NamaMenu,
                  ))),
        ));
  }
}
