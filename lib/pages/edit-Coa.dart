import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/pages/components/box-decoration.dart';
import 'package:uas_flutter/pages/components/chart.dart';
import 'package:uas_flutter/pages/components/header.dart';
import 'package:uas_flutter/pages/components/select-date.dart';
import 'package:uas_flutter/pages/list-transaksi.dart';
import 'package:uas_flutter/pages/components/pie-chart.dart';
import 'package:uas_flutter/view/category/createCategory.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

class CoaApp extends StatefulWidget {
  static const routeName = '/coa';
  final String namaCoa;
  final String kodeCoa;
  final int idCoa;
  const CoaApp(
      {super.key,
      required this.namaCoa,
      required this.kodeCoa,
      required this.idCoa});

  @override
  State<CoaApp> createState() => Coa();
}

class Coa extends State<CoaApp> {
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  int isPieChart = 0;
  int isChart = 0;
  List<GetWalletModel> listWallet = [
    GetWalletModel(idWallet: 0, NamaWallet: " ", TotalSaldo: 0, KodeCoa: "")
  ];
  List<GetTxModel> tagObjs = [
    GetTxModel(
      idTransaksi: 0,
      KeteranganTransaksi: "",
      nominal: 0,
      idUser: 0,
      idCoa: 0,
      TanggalTransaksi: "",
      CreatedAtHour: "",
      sisaSaldo: 0,
    ),
  ];
  int isHarian = 0;
  int isMingguan = 0;
  int isBulanan = 1;
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
  String tanggal = "";
  @override
  void initState() {
    super.initState();
    RecentTx();
    namaAkunController.text = widget.namaCoa;
    kodeAkunController.text = widget.kodeCoa;
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
    }
  }

  RecentTx() async {
    final gettxs = await context.read<TransaksiCubit>().getRecentTx(
          page: "1",
          pageSize: "100",
          tglAwal:
              '${_selectedDateRange.start.day}/${_selectedDateRange.start.month}/${_selectedDateRange.start.year}',
          tglAkhir:
              '${_selectedDateRange.end.day}/${_selectedDateRange.end.month}/${_selectedDateRange.end.year}',
          idCoaDebit: widget.idCoa,
          idCoaKredit: widget.idCoa,
        );
    gettxs.fold((failure) {}, (data) {
      setState(() {
        tagObjs = data;
      });
    });
  }

  TextEditingController namaAkunController = TextEditingController();
  TextEditingController kodeAkunController = TextEditingController();

  GetBeranda() async {
    final cubit = context.read<TransaksiCubit>();
    if (getberanda.isget == 0) {
      final result = await cubit.getBeranda(idWallet: widget.idCoa);
      result.fold(
        (failure) {
          // print('Error: ${failure.toString()}');
        },
        (data) {
          // print('Data received: ${data}');
          setState(() {
            getberanda = data;
          });
        },
      );
    }
  }

  String tglAwal = "";
  String tglAkhir = "";
  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(Duration(days: 365)),
    end: DateTime.now(),
  );

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
            appBar: HeaderCard(namaMenu: "Detail Coa ${widget.namaCoa}"),
            body: Container(
              width: 400,
              height: 920,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                        child: Container(
                            width: 400,
                            height: 920,
                            decoration: const BoxDecoration(
                              color: Color(0xffF5F7FF),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 343,
                                    height: 60,
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
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                20, 8, 20, 0),
                                            width: 303,
                                            height: 60,
                                            child: GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () async {},
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      // margin: const EdgeInsets
                                                      //     .fromLTRB(
                                                      //     20, 8, 20, 0),
                                                      color: Color.from(
                                                          alpha: 1,
                                                          red: 217,
                                                          green: 217,
                                                          blue: 217),
                                                      child: TextField(
                                                          controller:
                                                              namaAkunController,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              const InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            labelText:
                                                                'Nama Akun',
                                                            labelStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  'Plus Jakarta Sans',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              // height: 1.26,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      92,
                                                                      97,
                                                                      111),
                                                            ),
                                                          ),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Plus Jakarta Sans',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            // height: 1.26,
                                                            color: Colors.black,
                                                          ),
                                                          textAlign:
                                                              TextAlign.left),
                                                    ),
                                                  ],
                                                ))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 343,
                                    height: 70,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 4, 0, 4),
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
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                20, 8, 20, 0),
                                            width: 303,
                                            height: 70,
                                            child: GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () async {},
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      color: Color.from(
                                                          alpha: 1,
                                                          red: 217,
                                                          green: 217,
                                                          blue: 217),
                                                      child: TextField(
                                                          controller:
                                                              kodeAkunController,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration:
                                                              const InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            labelText:
                                                                'Kode Akun',
                                                            labelStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  'Plus Jakarta Sans',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              // height: 1.26,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      92,
                                                                      97,
                                                                      111),
                                                            ),
                                                          ),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Plus Jakarta Sans',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            // height: 1.26,
                                                            color: Colors.black,
                                                          ),
                                                          textAlign:
                                                              TextAlign.left),
                                                    ),
                                                  ],
                                                ))),
                                      ],
                                    ),
                                  ),
                                  SelectDateRangeApp(
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
                                      )),
                                  Container(
                                      width: 343,
                                      height: 428,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffffffff),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const [
                                          BoxShadow(
                                            color:
                                                Color.fromARGB(5, 17, 20, 177),
                                            offset: Offset(0, 3),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 343,
                                            // height: 428,
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () async {
                                                    GetBeranda();
                                                    setState(() {
                                                      isChart = 1;
                                                      isPieChart = 0;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 156,
                                                    height: 34,
                                                    margin: const EdgeInsets
                                                        .fromLTRB(4, 4, 4, 4),
                                                    decoration: isChart == 1
                                                        ? CustomBoxDecorations
                                                            .BoxActive()
                                                        : CustomBoxDecorations
                                                            .BoxNonActive(),
                                                    child: const Center(
                                                      child: Text(
                                                        'Grafik',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Plus Jakarta Sans',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 1.26,
                                                          color:
                                                              Color(0xff131313),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () async {
                                                    setState(() {
                                                      isChart = 0;
                                                      isPieChart = 1;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 156,
                                                    height: 34,
                                                    margin: const EdgeInsets
                                                        .fromLTRB(4, 4, 4, 4),
                                                    decoration: isPieChart == 1
                                                        ? CustomBoxDecorations
                                                            .BoxActive()
                                                        : CustomBoxDecorations
                                                            .BoxNonActive(),
                                                    child: const Center(
                                                      child: Text(
                                                        'Pie Chart',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Plus Jakarta Sans',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 1.26,
                                                          color:
                                                              Color(0xff131313),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          isPieChart == 1
                                              ? PieChartTransaksiApp()
                                              : ChartTransaksiApp(
                                                  idWallet: widget.idCoa,
                                                )
                                        ],
                                      )),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                    // padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
                                    width: 343,
                                    height: 125,
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
                                            itemCount: tagObjs.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var transaksis = tagObjs[index];
                                              // print(transaksis.data);
                                              // TODO:Getter model transaksi nya
                                              return ListTransaksiCard(
                                                transaksis.KeteranganTransaksi,
                                                transaksis.nominal,
                                                transaksis.sisaSaldo,
                                                transaksis.TanggalTransaksi,
                                                transaksis.idTransaksi,
                                              );
                                            },
                                          )))
                                        ],
                                      ),
                                    ),
                                  ),
                                ]))),
                    Container(
                        height: 48,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 39,
                            ),
                            Container(
                              // buttonlarge3KS (117:3606)
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              width: 146,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xff2c14dd),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {},
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
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              width: 146,
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
                        ))
                  ],
                ),
              ),
            )));
  }
}
