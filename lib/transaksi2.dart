import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
import 'package:flutter_svg/svg.dart';
import 'package:uas_flutter/createCategory.dart';
import 'package:uas_flutter/helper.dart';
import 'package:uas_flutter/models/response-go.dart';
import 'package:uas_flutter/models/response-go.dart' as GetTx;
import 'package:uas_flutter/pages/footer.dart';
import 'package:uas_flutter/pages/list-transaksi.dart';
import 'package:uas_flutter/repositories/golang-repository.dart';
import 'package:uas_flutter/repositories/transaksi-repository.dart';

class Transaksi2App extends StatefulWidget {
  Transaksi2App({Key? key, this.meta, this.tagObjs}) : super(key: key);
  GetTx.GetTransaksi? meta;
  List<GetTxModel>? tagObjs;
  List<GetWalletModel>? listWallet;
  String? dropdownWalletValue;
  @override
  State<Transaksi2App> createState() => Transaksi2();
}

class Transaksi2 extends State<Transaksi2App> {
  dynamic jsonlist;
  @override
  void initState() {
    super.initState();
    RecentTx();
    GetWallet();
  }

  GetTx.GetTransaksi? get meta => widget.meta;
  List<GetTxModel>? get tagObjs => widget.tagObjs;
  String? get dropdownWalletValue => widget.dropdownWalletValue;
  List<GetWalletModel>? get listWallet => widget.listWallet;
  RecentTx() async {
    print("meta recentTx");
    await TransaksiRepository().GetTransaksi("1", "10", "").then((jsonlist) {
      // print("jsonlist");
      // print(jsonlist.toString());
      // print("json");
      // print(json.decode(jsonlist.toString()));
      var responjson = json.decode(jsonlist.toString());
      Iterable jsonarray = (responjson['data']);
      List<GetTxModel> gettxs =
          List<GetTxModel>.from(jsonarray.map((model) => GetTxModel(
                idTransaksi: model["idTransaksi"],
                KeteranganTransaksi: model["KeteranganTransaksi"],
                idJenisTransaksi: model["idJenisTransaksi"],
                nominal: model["nominal"],
                idUser: model["idUser"],
                idWallet: model["idWallet"],
              )));
      // GetTx.GetTransaksi? gettx =
      // GetTx.GetTransaksi.fromJson(json.decode(jsonlist.toString()));
      // print("gettx.data");
      // print(gettx.data);
      // var tagObjsJson = jsonDecode(jsonlist.toString())['data'] as List;
      // List<GetTxModel> tagObjs =
      //     tagObjsJson.map((tagJson) => GetTxModel.fromJson(tagJson)).toList();
      setState(() {
        // widget.meta = gettx;
        widget.tagObjs = gettxs;
        print("setState Meta");
        // print(gettx);
      });
    }, onError: (e) => print("error completing $e"));
  }

  GetWallet() async {
    await UserRepository().GetWallet().then((jsonlist) {
      print("jsonlist");
      print(jsonlist);
      var responjson = json.decode(jsonlist.toString());
      Iterable jsonarray = (responjson['data']);
      List<GetWalletModel> getwallet = List<GetWalletModel>.from(jsonarray.map(
          (model) => GetWalletModel(
              idWallet: model["idWallet"], NamaWallet: model["namaWallet"])));
      print("getwallet");
      print(getwallet.first.NamaWallet);
      // var getwallet =
      //     GetTx.GetWalletModel.fromJson(json.decode(jsonlist.toString()));
      // var tagObjsJson = getwallet as List;
      // List<GetWalletModel> tagObjs = getwallet
      //     .map((tagJson) => GetWalletModel.fromJson(tagJson))
      //     .toList();
      // var listWallet =
      //     tagObjs.map((tagObjs) => tagObjs.NamaWallet as String).toList();
      // listWallet;
      setState(() {
        widget.listWallet = getwallet;
        // widget.meta = gettx;
        // widget.listWallet = tagObjs;
        print("setState listwallet");
        // print(gettx);
      });
    }, onError: (e) => print("error completing $e"));
    GetWalletModel;
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {});
    // print("meta");
    // print(this.meta.data);
    print("widget.listWallet");
    print(widget.listWallet!.first.NamaWallet);
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
                  height: 64,
                  child: Row(children: [
                    Container(
                      width: 170,
                      height: 46,
                      margin: const EdgeInsets.fromLTRB(20, 9, 114, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 152,
                            height: 20,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  width: 18,
                                  height: 18,
                                  child: SvgPicture.asset(
                                    'assets/Logo.svg',
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                                Container(
                                  child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      child: Text("Delete token"),
                                      onTap: () async {
                                        final storage.FlutterSecureStorage
                                            storages =
                                            storage.FlutterSecureStorage();
                                        await storages.delete(key: 'token');
                                        print("delete token");
                                      }),
                                ),
                                Container(
                                  width: 102,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: const Text(
                                    "Dompet Saya",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 1.26,
                                      color: Color(0xff131313),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: SvgPicture.asset(
                                    'assets/caret-arrow-up.svg',
                                    height: 16,
                                    width: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 170,
                            height: 18,
                            margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: const Text(
                              "Keuangan Kamu Terlihat Sehat",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 1.26,
                                color: Color(0xff5C616F),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 12, 16, 12),
                      child: SvgPicture.asset(
                        'assets/notif.svg',
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 24),
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
                          Container(
                              child: DropdownButton<String>(
                                  underline: const SizedBox(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      widget.dropdownWalletValue = value;
                                    });
                                    if (dropdownWalletValue ==
                                        "Create Wallet") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CreateCategoriesApp()));
                                    }
                                  },
                                  value: dropdownWalletValue,
                                  icon: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: SvgPicture.asset(
                                      'assets/caret-arrow-up.svg',
                                      height: 16,
                                      width: 16,
                                    ),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  items: widget.listWallet!
                                      .map((map) => DropdownMenuItem(
                                          value: map.NamaWallet,
                                          child: Text(map.NamaWallet)))
                                      .toList()

                                  //  listWallet!
                                  //     .map((map) => DropdownMenuItem(
                                  //           // value: map.idWallet,
                                  //           child: Text(map.NamaWallet),
                                  //         ))
                                  //     .toList(),
                                  ))
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
                            "Total Pengeluaran",
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
                  margin: const EdgeInsets.fromLTRB(16, 0, 150, 12),
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
                  height: 330,
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(children: [
                    SizedBox(
                      width: 311,
                      height: 42,
                      child: Row(
                        children: [
                          Container(
                            width: 150,
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
                            width: 149.5,
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
                                height: 162,
                                margin: const EdgeInsets.fromLTRB(9, 0, 0, 3),
                              ),
                              Container(
                                width: 311,
                                height: 16,
                                margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Row(children: [
                                  Container(
                                    width: 22,
                                    height: 16,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 7, 0),
                                    child: const Text(
                                      'Sun',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 25,
                                    height: 16,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 25, 0),
                                    child: const Text(
                                      'Mon',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 16,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    child: const Text(
                                      'Tue',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 27,
                                    height: 16,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 27, 0),
                                    child: const Text(
                                      'Wed',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 22,
                                    height: 16,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 22, 0),
                                    child: const Text(
                                      'Thu',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 14,
                                    height: 16,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 14, 0),
                                    child: const Text(
                                      'Fri',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 19,
                                    height: 16,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 7, 0),
                                    child: const Text(
                                      'Sat',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff848A9C),
                                      ),
                                    ),
                                  ),
                                ]),
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
                  margin: const EdgeInsets.fromLTRB(16, 0, 0, 12),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 20,
                        margin: const EdgeInsets.fromLTRB(24, 1.5, 96, 1.5),
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
                    // padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
                    width: 343,
                    height: 91,
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
                                  "");
                            },
                          )))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
        bottomNavigationBar: const FooterCard());
  }
}
