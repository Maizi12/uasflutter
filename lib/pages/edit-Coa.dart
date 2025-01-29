import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/chart_bar.dart';
import 'package:uas_flutter/helper/rupiah.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/pages/header.dart';
import 'package:uas_flutter/pages/list-transaksi.dart';
import 'package:uas_flutter/view/category/createCategory.dart';
import 'package:uas_flutter/view/transaksi/cubit/transaksi_cubit.dart';

class CoaApp extends StatefulWidget {
  static const routeName = '/coa';
  final String namaCoa;
  final String kodeCoa;
  const CoaApp({super.key, required this.namaCoa, required this.kodeCoa});

  @override
  State<CoaApp> createState() => Coa();
}

class Coa extends State<CoaApp> {
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
  List<GetJenisTransaksiModel> listJenisTransaksi = [
    GetJenisTransaksiModel(
        NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0)
  ];

  GetJenisTransaksiModel selectedjenisTransaksi = GetJenisTransaksiModel(
      NamaJenisTransaksi: "Create Kategori", idJenisTransaksi: 0);
  String? dropdownJenisTransaksiValue;

  @override
  void initState() {
    super.initState();
    RecentTx();
    GetJenisTransaksi();
    namaAkunController.text = widget.namaCoa;
    kodeAkunController.text = widget.kodeCoa;
  }

  RecentTx() async {
    final gettxs = await context.read<TransaksiCubit>().getRecentTx(
        page: "1",
        pageSize: "3",
        // id: selectedlistWallet.idCoa,
        // sort: selectedlistSort,
        idJenisTransaksi: selectedjenisTransaksi.idJenisTransaksi);
    gettxs.fold((failure) {}, (data) {
      setState(() {
        tagObjs = data;
      });
    });
  }

  TextEditingController namaAkunController = TextEditingController();
  TextEditingController kodeAkunController = TextEditingController();

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

  GetBeranda() async {
    final cubit = context.read<TransaksiCubit>();
    if (getberanda.isget == 0) {
      final result = await cubit.getBeranda(idWallet: 1);
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
            body: SingleChildScrollView(
                child: Container(
                    width: 400,
                    height: 800,
                    // height: 8,
                    // height: 85,
                    decoration: const BoxDecoration(
                      color: Color(0xffF5F7FF),
                    ),
                    child: Column(children: [
                      HeaderCard(namaMenu: "Detail Coa ${widget.namaCoa}"),
                      Container(
                        width: 280,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: const Color.fromARGB(255, 0, 17, 253),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                                width: 265,
                                height: 70,
                                child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {},
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.fromLTRB(
                                              4, 8, 4, 0),
                                          color: Color.from(
                                              alpha: 1,
                                              red: 217,
                                              green: 217,
                                              blue: 217),
                                          child: TextField(
                                              controller: namaAkunController,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        10, 0, 0, 0),
                                                labelText: 'Nama Akun',
                                              ),
                                              textAlign: TextAlign.left),
                                        ),
                                      ],
                                    ))),
                          ],
                        ),
                      ),
                      Container(
                        width: 280,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: const Color.fromARGB(255, 0, 17, 253),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                                width: 263,
                                height: 70,
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
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 0, 0, 0),
                                                      icon: const Visibility(
                                                          visible: false,
                                                          child: Icon(Icons
                                                              .arrow_downward)),
                                                      items: listJenisTransaksi.map(
                                                          (GetJenisTransaksiModel
                                                              value) {
                                                        return DropdownMenuItem<
                                                                GetJenisTransaksiModel>(
                                                            value: value,
                                                            child:
                                                                Wrap(children: [
                                                              Text(value
                                                                  .NamaJenisTransaksi),
                                                            ]));
                                                      }).toList()),
                                                ),
                                                const SizedBox(
                                                  width: 100,
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
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
                        width: 280,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: const Color.fromARGB(255, 0, 17, 253),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                                width: 265,
                                height: 70,
                                child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () async {},
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: const EdgeInsets.fromLTRB(
                                              4, 8, 4, 0),
                                          color: Color.from(
                                              alpha: 1,
                                              red: 217,
                                              green: 217,
                                              blue: 217),
                                          child: TextField(
                                              controller: kodeAkunController,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        10, 0, 0, 0),
                                                labelText: 'Kode Akun',
                                              ),
                                              textAlign: TextAlign.left),
                                        ),
                                      ],
                                    ))),
                          ],
                        ),
                      ),
                      Container(
                        width: 370,
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
                                      isHarian = 1;
                                      isMingguan = 0;
                                      isBulanan = 0;
                                    });
                                    GetBeranda();
                                  },
                                  child: Container(
                                    width: 98,
                                    height: 34,
                                    margin:
                                        const EdgeInsets.fromLTRB(4, 4, 4, 4),
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
                                      isHarian = 0;
                                      isMingguan = 1;
                                      isBulanan = 0;
                                    });
                                    GetBeranda();
                                  },
                                  child: Container(
                                    width: 98,
                                    height: 34,
                                    margin:
                                        const EdgeInsets.fromLTRB(4, 4, 4, 4),
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
                                      isHarian = 0;
                                      isMingguan = 0;
                                      isBulanan = 1;
                                    });
                                    GetBeranda();
                                  },
                                  child: Container(
                                    width: 99,
                                    height: 34,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 4, 0, 4),
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
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                        // padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
                        width: 343,
                        height: 120,

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
                                itemCount: 3,
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
                      SizedBox(
                          height: 48,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 39,
                              ),
                              Container(
                                // buttonlarge3KS (117:3606)
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
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
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                                width: 146,
                                height: 48,
                                // color: Colors.white,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(color: Colors.red, width: 2),
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
                    ])))));
  }
}
