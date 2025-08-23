import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uas_flutter/pages/components/chart.dart';
import 'package:uas_flutter/pages/components/dropdown-wallet.dart';
import 'package:uas_flutter/pages/new-multi-tx.dart';
import 'package:uas_flutter/util/data-fetch/beranda_helper.dart';
import 'package:uas_flutter/util/data-fetch/recenttx-helper.dart';
import 'package:uas_flutter/util/helper/helper.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/pages/all-tx.dart';
import 'package:uas_flutter/pages/components/footer.dart';
import 'package:uas_flutter/pages/list-transaksi.dart';
import 'package:uas_flutter/util/data-fetch/wallet_helper.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

class Transaksi2App extends StatefulWidget {
  static const routeName = '/transaksi';
  const Transaksi2App({super.key});
  // GetTx.GetTransaksi meta;

  @override
  State<Transaksi2App> createState() => Transaksi2();
}

class Transaksi2 extends State<Transaksi2App> {
  final _scrollController = ScrollController();
  int _currentPage = 1;
  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _currentPage++;
      });
    }
  }

  dynamic jsonlist;
  String NamaMenu = "Overview";
  List<GetTxModel> tagObjs = [
    GetTxModel.empty(),
  ];
  int isHarian = 0;
  int isMingguan = 0;
  int isBulanan = 1;
  int isVisible = 1;
  String textsaldo = "";
  List<GetWalletModel> listWallet = [
    GetWalletModel.empty()
    // GetWalletModel(idWallet: 0, NamaWallet: "Create Wallet", TotalSaldo: 0)
  ];
  GetWalletModel selectedlistWallet = GetWalletModel.empty();
  GetBerandaModel getberanda = GetBerandaModel.empty();

  bool _isLoading = true;
  String? error;

  bool _isFirstLoad = true;
  @override
  void initState() {
    super.initState();
    LoadWallet();
    if (_isFirstLoad && !_isLoading) {
      isBulanan = 1;
      _isFirstLoad = false;
    }
    _scrollController.addListener(_loadMore);
  }

  void RecentTx() async {
    final tx = await RecentTxGet(
        context, selectedlistWallet.idWallet, 0, "", "", _currentPage);
    if (tx.isNotEmpty) {
      setState(() {
        tagObjs = tx;
      });
    }
  }

  void LoadWallet() async {
    final wallets = await fetchWallet(context);
    if (wallets.isNotEmpty) {
      setState(() {
        listWallet.clear();
        listWallet.addAll(wallets);
        selectedlistWallet = (listWallet.isNotEmpty ? listWallet.first : null)!;
      });
      RecentTx();
    }
  }

  void GetBeranda() async {
    final res = await fetchBeranda(context, selectedlistWallet.idWallet);
    setState(() {
      getberanda = res;
    });
  }

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
                          height: 20,
                          margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                width: 30,
                                height: 20,
                                child: SvgPicture.asset(
                                  'assets/Logo.svg',
                                  height: 30,
                                  width: 20,
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  width: 130,
                                  height: 20,
                                  child: DropdownWalletApp(
                                    ListCoa: listWallet,
                                    selectedcoa: selectedlistWallet,
                                    selectCoa: (GetWalletModel select) {
                                      context
                                          .read<TransaksiCubit>()
                                          .selectWallet(select);
                                      selectedlistWallet = select;
                                      if (isVisible == 1) {
                                        textsaldo = "";
                                      } else {
                                        textsaldo = CurrencyFormat.convertToIdr(
                                            selectedlistWallet.TotalSaldo, 2);
                                      }
                                      _isLoading = false;
                                    },
                                    onupdate: () {
                                      RecentTx();
                                      GetBeranda();
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
                                  )),
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
                        width: 343,
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
                              child: Text(
                                selectedlistWallet.NamaWallet,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
                      margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
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
                      child: ChartTransaksiApp(
                        idWallet: selectedlistWallet.idWallet,
                      )),
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
                              context.push(AllTxApp.routeName);
                              context.namedLocation(AllTxApp.routeName);
                              context.go(AllTxApp.routeName);
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
                    child: Container(
                      width: 343,
                      height: 170,
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        shape: BoxShape.rectangle,
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
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                child: SizedBox(
                                    child: ListView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.zero,
                              itemCount: (_currentPage * 10 >= tagObjs.length
                                  ? tagObjs.length
                                  : _currentPage * 10),
                              itemBuilder: (BuildContext context, int index) {
                                var transaksis = tagObjs[index];
                                return ListTransaksiCard(
                                  transaksis.KeteranganTransaksi,
                                  transaksis.nominal,
                                  transaksis.sisaSaldo,
                                  transaksis.TanggalTransaksi,
                                  transaksis.DebitKredit,
                                  transaksis.idTransaksi,
                                );
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
                    // context.push(AllTxApp.routeName);
                    //           context.namedLocation(AllTxApp.routeName);
                    //           context.go(AllTxApp.routeName);
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
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: FooterCard(
                    namaMenu: NamaMenu,
                  ))),
        ));
  }
}
