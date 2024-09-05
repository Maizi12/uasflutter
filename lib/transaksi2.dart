import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/createCategory.dart';
import 'package:uas_flutter/createTransaksi.dart';
import 'package:uas_flutter/helper.dart';
import 'package:uas_flutter/models/daysmodel/daysmodel.dart';
import 'package:uas_flutter/models/monthmodel/monthmodel.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/models/weekmodel/weekmodel.dart';
import 'package:uas_flutter/pages/footer.dart';
import 'package:uas_flutter/pages/list-transaksi.dart';
import 'package:uas_flutter/repositories/golang-repository.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';

class Transaksi2App extends StatefulWidget {
  Transaksi2App({Key? key}) : super(key: key);
  // GetTx.GetTransaksi meta;
  List<GetTxModel> tagObjs = [
    GetTxModel(
      idTransaksi: 0,
      KeteranganTransaksi: "",
      idJenisTransaksi: 0,
      nominal: 0,
      idUser: 0,
      idWallet: 0,
    ),
  ];
  int isHarian = 1;
  int isMingguan = 0;
  int isBulanan = 0;
  List<GetWalletModel> listWallet = [
    GetWalletModel(idWallet: 0, NamaWallet: " ", TotalSaldo: 0)
  ];
  GetWalletModel selectedlistWallet =
      GetWalletModel(idWallet: 0, NamaWallet: "z", TotalSaldo: 1);
  GetBerandaModel getberanda = GetBerandaModel(
    totalPemasukan: 0,
    totalPengeluaran: 0,
    totalSisa: 0,
    sunday: Sunday(pemasukanSunday: 0, pengeluaranSunday: 0),
    monday: Monday(pemasukanMonday: 0, pengeluaranMonday: 0),
    tuesday: Tuesday(pemasukanTuesday: 0, pengeluaranTuesday: 0),
    wednesday: Wednesday(pemasukanWednesday: 0, pengeluaranWednesday: 0),
    thursday: Thursday(pemasukanThursday: 0, pengeluaranThursday: 0),
    friday: Friday(pemasukanFriday: 0, pengeluaranFriday: 0),
    saturday: Saturday(pemasukanSaturday: 0, pengeluaranSaturday: 0),
    week1: Week1(pemasukanWeek1: 0, pengeluaranWeek1: 0),
    week2: Week2(pemasukanWeek2: 0, pengeluaranWeek2: 0),
    week3: Week3(pemasukanWeek3: 0, pengeluaranWeek3: 0),
    week4: Week4(pemasukanWeek4: 0, pengeluaranWeek4: 0),
    week5: Week5(pemasukanWeek5: 0, pengeluaranWeek5: 0),
    jan: Januari(pemasukanJanuari: 0, pengeluaranJanuari: 0),
    feb: Februari(pemasukanFebruari: 0, pengeluaranFebruari: 0),
    mar: Maret(pemasukanMaret: 0, pengeluaranMaret: 0),
    apr: April(pemasukanApril: 0, pengeluaranApril: 0),
    mei: Mei(pemasukanMei: 0, pengeluaranMei: 0),
    jun: Juni(pemasukanJuni: 0, pengeluaranJuni: 0),
    jul: Juli(pemasukanJuli: 0, pengeluaranJuli: 0),
    agu: Agustus(pemasukanAgustus: 0, pengeluaranAgustus: 0),
    sep: September(pemasukanSeptember: 0, pengeluaranSeptember: 0),
    okt: Oktober(pemasukanOktober: 0, pengeluaranOktober: 0),
    nov: November(pemasukanNovember: 0, pengeluaranNovember: 0),
    des: Desember(pemasukanDesember: 0, pengeluaranDesember: 0),
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
      // widget.listWallet.clear();
      widget.listWallet = getwallets;
      // widget.dropdownWalletValue = getwallets.first.NamaWallet;
      widget.selectedlistWallet = getwallets.first;
      widget.listWallet.add(GetWalletModel(
          NamaWallet: "Create Wallet", idWallet: 0, TotalSaldo: 0));
    });
  }

  GetBeranda() async {
    GetBerandaModel getwallets;
    if (widget.getberanda ==
        GetBerandaModel(
          totalPemasukan: 0,
          totalPengeluaran: 0,
          totalSisa: 0,
          sunday: Sunday(pemasukanSunday: 0, pengeluaranSunday: 0),
          monday: Monday(pemasukanMonday: 0, pengeluaranMonday: 0),
          tuesday: Tuesday(pemasukanTuesday: 0, pengeluaranTuesday: 0),
          wednesday: Wednesday(pemasukanWednesday: 0, pengeluaranWednesday: 0),
          thursday: Thursday(pemasukanThursday: 0, pengeluaranThursday: 0),
          friday: Friday(pemasukanFriday: 0, pengeluaranFriday: 0),
          saturday: Saturday(pemasukanSaturday: 0, pengeluaranSaturday: 0),
          week1: Week1(pemasukanWeek1: 0, pengeluaranWeek1: 0),
          week2: Week2(pemasukanWeek2: 0, pengeluaranWeek2: 0),
          week3: Week3(pemasukanWeek3: 0, pengeluaranWeek3: 0),
          week4: Week4(pemasukanWeek4: 0, pengeluaranWeek4: 0),
          week5: Week5(pemasukanWeek5: 0, pengeluaranWeek5: 0),
          jan: Januari(pemasukanJanuari: 0, pengeluaranJanuari: 0),
          feb: Februari(pemasukanFebruari: 0, pengeluaranFebruari: 0),
          mar: Maret(pemasukanMaret: 0, pengeluaranMaret: 0),
          apr: April(pemasukanApril: 0, pengeluaranApril: 0),
          mei: Mei(pemasukanMei: 0, pengeluaranMei: 0),
          jun: Juni(pemasukanJuni: 0, pengeluaranJuni: 0),
          jul: Juli(pemasukanJuli: 0, pengeluaranJuli: 0),
          agu: Agustus(pemasukanAgustus: 0, pengeluaranAgustus: 0),
          sep: September(pemasukanSeptember: 0, pengeluaranSeptember: 0),
          okt: Oktober(pemasukanOktober: 0, pengeluaranOktober: 0),
          nov: November(pemasukanNovember: 0, pengeluaranNovember: 0),
          des: Desember(pemasukanDesember: 0, pengeluaranDesember: 0),
        )) {
      getwallets = await GetBerandaData(widget.selectedlistWallet!.idWallet);
    } else {
      getwallets = widget.getberanda;
    }
    setState(() {
      if (widget.isHarian == 1) {
        widget._data1 = [
          {"name": 'sun', 'value': getwallets.sunday.pemasukanSunday},
          {"name": 'mon', "value": getwallets.monday.pemasukanMonday},
          {"name": 'tue', "value": getwallets.tuesday.pemasukanTuesday},
          {"name": 'wed', "value": getwallets.wednesday.pemasukanWednesday},
          {"name": 'thu', "value": getwallets.thursday.pemasukanThursday},
          {"name": 'fri', "value": getwallets.friday.pemasukanFriday},
          {"name": 'sat', "value": getwallets.saturday.pemasukanSaturday},
        ];
      } else if (widget.isMingguan == 1) {
        widget._data1 = [
          {"name": 'week1', 'value': getwallets.week1.pemasukanWeek1},
          {"name": 'week2', "value": getwallets.week2.pemasukanWeek2},
          {"name": 'week3', "value": getwallets.week3.pemasukanWeek3},
          {"name": 'week4', "value": getwallets.week4.pemasukanWeek4},
          {"name": 'week5', "value": getwallets.week5.pemasukanWeek5},
        ];
      } else if (widget.isBulanan == 1) {
        widget._data1 = [
          {"name": 'jan', 'value': getwallets.jan.pemasukanJanuari},
          {"name": 'feb', "value": getwallets.feb.pemasukanFebruari},
          {"name": 'mar', "value": getwallets.mar.pemasukanMaret},
          {"name": 'apr', "value": getwallets.apr.pemasukanApril},
          {"name": 'mei', "value": getwallets.mei.pemasukanMei},
          {"name": 'jun', 'value': getwallets.jun.pemasukanJuni},
          {"name": 'jul', "value": getwallets.jul.pemasukanJuli},
          {"name": 'agu', "value": getwallets.agu.pemasukanAgustus},
          {"name": 'sep', "value": getwallets.sep.pemasukanSeptember},
          {"name": 'okt', "value": getwallets.okt.pemasukanOktober},
          {"name": 'nov', 'value': getwallets.nov.pemasukanNovember},
          {"name": 'des', "value": getwallets.des.pemasukanDesember},
        ];
      }
      widget.getberanda = getwallets;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.listWallet[0].NamaWallet);
    // print(widget.selectedlistWallet!.NamaWallet);
    // print(widget.selectedlistWallet!.idWallet);
    // print(widget.selectedlistWallet!.TotalSaldo);
    return Scaffold(
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
                SizedBox(
                    width: 375,
                    height: 50,
                    child: Column(children: [
                      Container(
                        width: 375,
                        height: 37,
                        margin: const EdgeInsets.fromLTRB(10, 9, 0, 0),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              width: 18,
                              height: 18,
                              child: SvgPicture.asset(
                                'assets/Logo.svg',
                                height: 18,
                                width: 18,
                              ),
                            ),
                            Container(
                              // margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              width: 130,
                              height: 20,
                              child: DropdownButton<GetWalletModel>(
                                value: widget.selectedlistWallet,
                                underline: const SizedBox(),
                                items: widget.listWallet
                                    .map((GetWalletModel value) {
                                  return new DropdownMenuItem<GetWalletModel>(
                                      value: value,
                                      child: new Wrap(children: [
                                        Text(value.NamaWallet),
                                      ]));
                                }).toList(),
                                onChanged: (GetWalletModel? value) {
                                  setState(() {
                                    widget.selectedlistWallet = value!;
                                    GetBeranda();
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
                                      const EdgeInsets.fromLTRB(15, 0, 0, 0),
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
                              margin: const EdgeInsets.fromLTRB(90, 0, 0, 0),
                              width: 100,
                              child: SvgPicture.asset(
                                'assets/notif.svg',
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),
                Container(
                  // width: 120,
                  // height: 18,
                  margin: const EdgeInsets.fromLTRB(0, 0, 120, 0),
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
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  width: 343,
                  height: 107,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(8),
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
                      width: 311,
                      height: 14,
                      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            margin: const EdgeInsets.fromLTRB(0, 0, 194, 0),
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
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 1, 4, 1),
                            width: 12,
                            height: 12,
                            child: SvgPicture.asset(
                              'assets/Logo.svg',
                              height: 12,
                              width: 12,
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
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                                  width: 24,
                                  height: 16,
                                  child: SvgPicture.asset(
                                    'assets/eye.svg',
                                    height: 16,
                                    width: 16,
                                  ),
                                )
                              ]),
                        )
                      ]),
                    )
                  ]),
                ),
                Container(
                  width: 139,
                  height: 20,
                  margin: const EdgeInsets.fromLTRB(16, 0, 150, 8),
                  child: const Text(
                    "Laporan Pengeluaran",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff161719),
                    ),
                  ),
                ),
                Container(
                  width: 343,
                  height: 300,
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
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
                          Container(
                            width: 103,
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
                          Container(
                            width: 103,
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
                          Container(
                            width: 103,
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
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 311,
                      height: 232,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        children: [
                          Container(
                            width: 311,
                            height: 181,
                            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Column(children: [
                              Container(
                                width: 302,
                                height: 178,
                                margin: const EdgeInsets.fromLTRB(9, 0, 0, 3),
                                //chart
                                child: Echarts(
                                  // xAxis: {
                                  //   type: 'category',
                                  //   data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                                  // },
                                  // yAxis: {
                                  //   type: 'value'
                                  // },
                                  option: '''
                                  {
                                    xAxis: {
                                      type: 'category',
                                    },
                                    yAxis: {
                                      type: 'value'
                                    },
                                    dataset:{
                                    dimensions:['name','value'],
                                    source: ${jsonEncode(widget._data1)},
                                    },
                                    series: [{
                                      
                                      type: 'bar',
                                      barWidth: '80%',
                                      barHeight: '100%'
                                    }],
                                    grid: {
                                      left: '0%',
                                      right: '0%',
                                      bottom: '5%',
                                      top: '7%',
                                      width:'100%',
                                      height: '100%',
                                      containLabel: true,
                                      z: 22,
                                    },
                                    itemStyle: {
                                      barBorderRadius: 5,
                                      borderWidth: 2,
                                    },
                                  }
                                ''',
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            width: 311,
                            height: 35,
                            margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                            child: Row(children: [
                              SizedBox(
                                width: 93,
                                height: 35,
                                child: Column(children: [
                                  Container(
                                    width: 67,
                                    height: 13,
                                    margin:
                                        const EdgeInsets.fromLTRB(4, 0, 22, 0),
                                    child: Row(children: [
                                      Container(
                                        // oval8P6 (117:2777)
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 4, 0),
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              width: 2,
                                              color: const Color(0xff1fde00)),
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 55,
                                        height: 13,
                                        child: Text(
                                          // shoppingS8t (117:2778)
                                          'Pemasukan',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff83899b),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                  Container(
                                    width: 89,
                                    height: 18,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 4, 4, 0),
                                    child: const Text(
                                      "Rp 17,000,000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff161719),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                              SizedBox(
                                width: 93,
                                height: 35,
                                child: Column(children: [
                                  Container(
                                    width: 67,
                                    height: 13,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 22, 0),
                                    child: Row(children: [
                                      Container(
                                        // oval8P6 (117:2777)
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 4, 0),
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              width: 2,
                                              color: const Color(0xffff4040)),
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 55,
                                        height: 13,
                                        child: Text(
                                          // shoppingS8t (117:2778)
                                          'Pengeluaran',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff83899b),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                  Container(
                                    width: 89,
                                    height: 18,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 4, 4, 0),
                                    child: const Text(
                                      "Rp 2,500,000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff161719),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                              SizedBox(
                                width: 93,
                                height: 35,
                                child: Column(children: [
                                  Container(
                                    width: 67,
                                    height: 13,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 22, 0),
                                    child: Row(children: [
                                      Container(
                                        // oval8P6 (117:2777)
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 4, 0),
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: const Color(0xffffffff),
                                          border: const Border(),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 55,
                                        height: 13,
                                        child: Text(
                                          // shoppingS8t (117:2778)
                                          'Tersisa',
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff83899b),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                  Container(
                                    width: 89,
                                    height: 18,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 4, 4, 0),
                                    child: const Text(
                                      "Rp 2,500,000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff161719),
                                      ),
                                    ),
                                  )
                                ]),
                              )
                            ]),
                          )
                        ],
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
                      const SizedBox(
                        width: 71,
                        height: 17,
                        child: Text(
                          "Lihat Semua",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff2C14DD),
                          ),
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
                child:
                    Container(child: SvgPicture.asset("assets/plus-white.svg")),
                //TOOD:ini belum floating button
              ),
            )),
        bottomNavigationBar: const FooterCard());
  }
}
