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
      DebitKredit: "",
      nominal: 0,
      idUser: 0,
      idWallet: 0,
    ),
  ];
  int isHarian = 1;
  int isMingguan = 0;
  int isBulanan = 0;
  int isVisible = 1;
  List<GetWalletModel> listWallet = [
    GetWalletModel(idWallet: 0, NamaWallet: " ", TotalSaldo: 0)
  ];
  GetWalletModel selectedlistWallet =
      GetWalletModel(idWallet: 0, NamaWallet: "z", TotalSaldo: 1);
  GetBerandaModel getberanda = GetBerandaModel(
    totalDebit: 0,
    totalKredit: 0,
    totalSisa: 0,
    sunday: Sunday(debitSunday: 0, kreditSunday: 0),
    monday: Monday(debitMonday: 0, kreditMonday: 0),
    tuesday: Tuesday(debitTuesday: 0, kreditTuesday: 0),
    wednesday: Wednesday(debitWednesday: 0, kreditWednesday: 0),
    thursday: Thursday(debitThursday: 0, kreditThursday: 0),
    friday: Friday(debitFriday: 0, kreditFriday: 0),
    saturday: Saturday(debitSaturday: 0, kreditSaturday: 0),
    week1: Week1(debitWeek1: 0, kreditWeek1: 0),
    week2: Week2(debitWeek2: 0, kreditWeek2: 0),
    week3: Week3(debitWeek3: 0, kreditWeek3: 0),
    week4: Week4(debitWeek4: 0, kreditWeek4: 0),
    jan: Januari(debitJanuari: 0, kreditJanuari: 0),
    feb: Februari(debitFebruari: 0, kreditFebruari: 0),
    mar: Maret(debitMaret: 0, kreditMaret: 0),
    apr: April(debitApril: 0, kreditApril: 0),
    mei: Mei(debitMei: 0, kreditMei: 0),
    jun: Juni(debitJuni: 0, kreditJuni: 0),
    jul: Juli(debitJuli: 0, kreditJuli: 0),
    agu: Agustus(debitAgustus: 0, kreditAgustus: 0),
    sep: September(debitSeptember: 0, kreditSeptember: 0),
    okt: Oktober(debitOktober: 0, kreditOktober: 0),
    nov: November(debitNovember: 0, kreditNovember: 0),
    des: Desember(debitDesember: 0, kreditDesember: 0),
    isget: 0,
    idWallet: 0,
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
    print("GetBeranda");
    GetBerandaModel getwallets;
    if (widget.getberanda.isget == 0) {
      getwallets = await GetBerandaData(widget.selectedlistWallet!.idWallet);
    } else {
      getwallets = widget.getberanda;
    }
    if (widget.selectedlistWallet.idWallet != getwallets.idWallet) {
      getwallets = await GetBerandaData(widget.selectedlistWallet!.idWallet);
    }
    print(widget.getberanda);
    print(widget.getberanda.totalDebit);
    print(widget.getberanda.totalKredit);
    print(widget.getberanda.totalSisa);
    print("widget.isHarian");
    print(widget.isHarian);
    print("widget.isBulanan");
    print(widget.isBulanan);
    print("widget.isMingguan");
    print(widget.isMingguan);
    setState(() {
      if (widget.isHarian == 1) {
        widget._data1 = [
          {"name": 'sun', 'value': getwallets.sunday.debitSunday},
          {"name": 'mon', "value": getwallets.monday.debitMonday},
          {"name": 'tue', "value": getwallets.tuesday.debitTuesday},
          {"name": 'wed', "value": getwallets.wednesday.debitWednesday},
          {"name": 'thu', "value": getwallets.thursday.debitThursday},
          {"name": 'fri', "value": getwallets.friday.debitFriday},
          {"name": 'sat', "value": getwallets.saturday.debitSaturday},
        ];
      } else if (widget.isMingguan == 1) {
        widget._data1 = [
          {"name": 'week1', 'value': getwallets.week1.debitWeek1},
          {"name": 'week2', "value": getwallets.week2.debitWeek2},
          {"name": 'week3', "value": getwallets.week3.debitWeek3},
          {"name": 'week4', "value": getwallets.week4.debitWeek4},
        ];
      } else if (widget.isBulanan == 1) {
        widget._data1 = [
          {"name": 'jan', 'value': getwallets.jan.debitJanuari},
          {"name": 'feb', "value": getwallets.feb.debitFebruari},
          {"name": 'mar', "value": getwallets.mar.debitMaret},
          {"name": 'apr', "value": getwallets.apr.debitApril},
          {"name": 'mei', "value": getwallets.mei.debitMei},
          {"name": 'jun', 'value': getwallets.jun.debitJuni},
          {"name": 'jul', "value": getwallets.jul.debitJuli},
          {"name": 'agu', "value": getwallets.agu.debitAgustus},
          {"name": 'sep', "value": getwallets.sep.debitSeptember},
          {"name": 'okt', "value": getwallets.okt.debitOktober},
          {"name": 'nov', 'value': getwallets.nov.debitNovember},
          {"name": 'des', "value": getwallets.des.debitDesember},
        ];
      }
      widget.getberanda = getwallets;
    });
    print("widget._data1");
    print(widget._data1);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.listWallet[0].NamaWallet);
    // print(widget.selectedlistWallet!.NamaWallet);
    // print(widget.selectedlistWallet!.idWallet);
    // print(widget.selectedlistWallet!.TotalSaldo);
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
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
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  width: 18,
                                  height: 18,
                                  child: SvgPicture.asset(
                                    'assets/Logo.svg',
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                  width: 130,
                                  height: 20,
                                  child: DropdownButton<GetWalletModel>(
                                    value: widget.selectedlistWallet,
                                    underline: const SizedBox(),
                                    items: widget.listWallet
                                        .map((GetWalletModel value) {
                                      return new DropdownMenuItem<
                                              GetWalletModel>(
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
                                      if (value!.NamaWallet ==
                                          "Create Wallet") {
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
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(88, 0, 0, 0),
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
                      height: 99,
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
                                      child: Text(
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
                    Container(
                      width: 139,
                      height: 20,
                      margin: const EdgeInsets.fromLTRB(16, 4, 150, 8),
                      child: const Text(
                        "Laporan Kredit",
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
                        SingleChildScrollView(
                          child: Container(
                            width: 311,
                            height: 232,
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              children: [
                                Container(
                                  width: 311,
                                  height: 181,
                                  // margin:
                                  // const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: Column(children: [
                                    Container(
                                      width: 311,
                                      height: 178,
                                      margin:
                                          const EdgeInsets.fromLTRB(9, 0, 0, 3),
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
                                    xAxis: [{
                                      type: 'category',
                                      gridIndex:0,
                                      axisLabel: {
                                      show: true,
                                      color: 'rgb(170,170,170)',
                                      formatter: function xFormatter(value, index) {
                                        return `\${value}\\n*`;
                                      },
                                      // splitNumber:index,
                                    },
                                    }],
                                    yAxis: {
                                      type: 'value',
                                       splitNumber: 12,
                                    },
                                    dataset:{
                                    dimensions:['name','value'],
                                    source: ${jsonEncode(widget._data1)},
                                    },
                                    series: [{
                                      type: 'bar',
                                      barWidth: '70%',
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
                                  margin:
                                      const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: Row(children: [
                                    SizedBox(
                                      width: 93,
                                      height: 35,
                                      child: Column(children: [
                                        Container(
                                          width: 67,
                                          height: 13,
                                          margin: const EdgeInsets.fromLTRB(
                                              4, 0, 22, 0),
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
                                                    color: const Color(
                                                        0xff1fde00)),
                                                color: const Color(0xffffffff),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 55,
                                              height: 13,
                                              child: Text(
                                                // shoppingS8t (117:2778)
                                                'Debit',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
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
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 4, 4, 0),
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
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 22, 0),
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
                                                    color: const Color(
                                                        0xffff4040)),
                                                color: const Color(0xffffffff),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 55,
                                              height: 13,
                                              child: Text(
                                                // shoppingS8t (117:2778)
                                                'Kredit',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
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
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 4, 4, 0),
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
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 22, 0),
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
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
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
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 4, 4, 0),
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
                        )
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
                ))),
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
