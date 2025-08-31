import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/pages/components/dropdown-display-item.dart';
import 'package:uas_flutter/pages/components/dropdown-sort.dart';
import 'package:uas_flutter/pages/components/dropdown-wallet.dart';
import 'package:uas_flutter/pages/components/footer.dart';
import 'package:uas_flutter/pages/components/select-date.dart';
import 'package:uas_flutter/pages/styles/textstyle.dart';
import 'package:uas_flutter/util/data-fetch/recenttx-helper.dart';
import 'package:uas_flutter/util/data-fetch/wallet_helper.dart';
import 'package:uas_flutter/view/category/createCategory.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/pages/list-transaksi.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

class AllTxApp extends StatefulWidget {
  static const routeName = '/alltx';

  AllTxApp({super.key});

  @override
  State<AllTxApp> createState() => AllTx();
}

class AllTx extends State<AllTxApp> {
  final _scrollController = ScrollController();
  int _currentPage = 1;
  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _currentPage++;
      });
      RecentTx();
    }
  }

  String NamaMenu = "Transaksi";
  List<GetWalletModel> listWallet = [];
  List<GetTxModel> tagObjs = [];
  String tanggal = "Pilih Tanggal";
  String tglAwal = "";
  String tglAkhir = "";
  List<GetJenisCoaModel> listJenisTransaksi = [];
  List<String> DebitKredit = ["Debit", "Kredit"];
  String selectedDebitKredit = "Debit";
  bool isDebit = true, isKredit = false;
  GetJenisCoaModel selectedjenisTransaksi =
      GetJenisCoaModel(NamaJenisCoa: "Create Kategori", idJenisCoa: 0);
  String? dropdownJenisTransaksiValue;
  GetWalletModel selectedlistWallet =
      GetWalletModel(idWallet: 0, NamaWallet: "", TotalSaldo: 1, KodeCoa: "");
  String selectedlistSort = "Terbaru";
  int selectedlistSortTampil = 10;
  void LoadWallet() async {
    final wallets = await fetchWallet(context);
    if (wallets.isNotEmpty) {
      setState(() {
        listWallet.clear();
        listWallet.addAll(wallets);
        listWallet.add(GetWalletModel.createWallet());
        selectedlistWallet = (listWallet.isNotEmpty ? listWallet.first : null)!;
      });
      RecentTx();
    }
  }

  @override
  void initState() {
    LoadWallet();
    GetJenisTransaksi();
    super.initState();
    _scrollController.addListener(_loadMore);
  }

  RecentTx() async {
    if (selectedlistWallet.idWallet != 0) {
      final gettxs = await RecentTxGet(
          context,
          selectedlistWallet.idWallet,
          0,
          '${_selectedDateRange.start.year}-${_selectedDateRange.start.month}-${_selectedDateRange.start.day}',
          '${_selectedDateRange.end.year}-${_selectedDateRange.end.month}-${_selectedDateRange.end.day}',
          _currentPage);
      setState(() {
        tagObjs = gettxs;
      });
    }
  }

  GetJenisTransaksi() async {
    final gettxs = await context.read<TransaksiCubit>().GetJenisTransaksi();
    if (gettxs.isNotEmpty) {
      setState(() {
        listJenisTransaksi.clear();

        listJenisTransaksi.addAll(gettxs);
        selectedjenisTransaksi = listJenisTransaksi.first;
        dropdownJenisTransaksiValue = gettxs.first.NamaJenisCoa;
      });
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
        // appBar: HeaderCard(namaMenu: "All $NamaMenu"),
        body: Container(
            width: 375,
            // height: 8,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 245, 247, 255),
            ),
            height: 1050,
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                width: 355,
                height: 700,
                child: Column(
                  children: [
                    Container(
                      width: 355,
                      height: 70,
                      // margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            width: 18,
                            height: 18,
                            child: SvgPicture.asset(
                              'assets/Logo.svg',
                              height: 18,
                              width: 18,
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              width: 115,
                              height: 20,
                              child: DropdownWalletApp(
                                ListCoa: listWallet,
                                selectCoa: (GetWalletModel select) {
                                  context
                                      .read<TransaksiCubit>()
                                      .selectWallet(select);
                                  selectedlistWallet = select;
                                  // RecentTx();
                                },
                                selectedcoa: selectedlistWallet,
                                icon: SvgPicture.asset(
                                  'assets/caret-arrow-up.svg',
                                  height: 16,
                                  width: 16,
                                ),
                                onupdate: () {
                                  RecentTx();
                                  // widget.onupdate?.call();
                                },
                              )),
                          SizedBox(
                            width: 200,
                            height: 33,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 16,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        margin: const EdgeInsets.fromLTRB(
                                            36, 0, 0, 0),
                                        child: Text(
                                          "Urutkan:",
                                          style: CustomTextStyle.StyleList(),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            4, 0, 0, 0),
                                        width: 110,
                                        height: 20,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: DropdownSortApp(
                                            onupdate: () {
                                              setState(() {
                                                RecentTx();
                                              });
                                            },
                                            icon: SvgPicture.asset(
                                              'assets/caret-arrow-up.svg',
                                              height: 16,
                                              width: 16,
                                            ),
                                            selectSort: (String) {
                                              setState(() {
                                                selectedlistSort = String;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 16,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        margin: const EdgeInsets.fromLTRB(
                                            36, 0, 0, 0),
                                        child: Text(
                                          "Tampil:",
                                          style: CustomTextStyle.StyleList(),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            4, 0, 0, 0),
                                        width: 110,
                                        height: 20,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: DropdownDisplayItemApp(
                                            onupdate: () {
                                              setState(() {
                                                RecentTx();
                                              });
                                            },
                                            icon: SvgPicture.asset(
                                              'assets/caret-arrow-up.svg',
                                              height: 16,
                                              width: 16,
                                            ),
                                            selectDisplayItem: (Int) {
                                              setState(() {
                                                selectedlistSortTampil = Int;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                          Container(
                              width: 300,
                              height: 56,
                              margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    _selectDateRange(context);
                                  },
                                  child: SelectDateRangeApp(
                                      onDatesSelected: (DateTimeRange date) {
                                        setState(() {
                                          _selectedDateRange = date;
                                          RecentTx();
                                        });
                                      },
                                      tgl: (String tgls) {
                                        setState(() {
                                          tanggal = tgls;
                                        });
                                      },
                                      tglAwal: (String tgl) {
                                        setState(() {
                                          tglAwal = tgl;
                                        });
                                      },
                                      tglAkhir: (String tgl) {
                                        setState(() {
                                          tglAkhir = tgl;
                                        });
                                      },
                                      child: SelectDateDefault(
                                        selectedDate: tanggal,
                                      ))))

                          // ),
                        ],
                      ),
                    ),
                    // TODO: Comment Kategori Tx
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Row(
                        children: [
                          GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {},
                              child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                                          width: 383,
                                          height: 21,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                child: DropdownButton<
                                                        GetJenisCoaModel>(
                                                    underline: const SizedBox(),
                                                    value:
                                                        selectedjenisTransaksi,
                                                    onChanged:
                                                        (GetJenisCoaModel?
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
                                                    icon: Container(
                                                        height: 24,
                                                        width: 24,
                                                        margin: const EdgeInsets
                                                            .fromLTRB(
                                                            100, 0, 0, 0),
                                                        child: Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 24,
                                                        )),
                                                    items: listJenisTransaksi
                                                        .map((GetJenisCoaModel
                                                            value) {
                                                      return DropdownMenuItem<
                                                              GetJenisCoaModel>(
                                                          value: value,
                                                          child:
                                                              Wrap(children: [
                                                            Text(value
                                                                .NamaJenisCoa),
                                                          ]));
                                                    }).toList()),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ))),
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Row(
                        children: [
                          GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {},
                              child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                  width: 263,
                                  height: 50,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: const Text(
                                          "Debit/Kredit",
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      SizedBox(
                                          width: 383,
                                          height: 21,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                child: DropdownButton<String>(
                                                    underline: const SizedBox(),
                                                    value: selectedDebitKredit,
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        selectedDebitKredit =
                                                            value!;
                                                        if (selectedDebitKredit ==
                                                            "Debit") {
                                                          isDebit = true;
                                                          isKredit = false;
                                                        } else {
                                                          isKredit = true;
                                                          isDebit = true;
                                                        }
                                                        RecentTx();
                                                      });
                                                    },
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 0),
                                                    icon: Container(
                                                        height: 24,
                                                        width: 24,
                                                        margin: const EdgeInsets
                                                            .fromLTRB(
                                                            100, 0, 0, 0),
                                                        child: Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 24,
                                                        )),
                                                    items: DebitKredit.map(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                              String>(
                                                          value: value,
                                                          child:
                                                              Wrap(children: [
                                                            Text(value),
                                                          ]));
                                                    }).toList()),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ))),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        // padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
                        width: 343,
                        height: 275,
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
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                  child: SizedBox(
                                      child: ListView.builder(
                                controller: _scrollController,
                                padding: EdgeInsets.zero,
                                itemCount:
                                    // _currentPage * 10
                                    (_currentPage * 10 >= tagObjs.length
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
                ),
              )
            ])),

        bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
                width: 390,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: FooterCard(
                  namaMenu: NamaMenu,
                ))),
      ),
    );
  }
}
