// import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uas_flutter/createCategory.dart';
import 'package:uas_flutter/createTransaksi.dart';
import 'package:uas_flutter/models/kategori.dart';
import 'package:uas_flutter/models/user.dart';
import 'package:uas_flutter/models/wallet.dart';
import 'package:uas_flutter/models/transaksi.dart';
import 'package:uas_flutter/pages/footer.dart';
// import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:uas_flutter/pages/list-transaksi.dart';

class Userid {
  int index;
  Userid(this.index);
}

class TransaksiApp extends StatefulWidget {
  TransaksiApp({
    Key? key,
    this.restorationId,
    this.dropdownWalletValue,
    // this.userid,
    // this.kategoriTransaksiLists,
    // this.listKategori,
    // this.walletslists,
    // this.listWallet,
  }) : super(key: key);
  final String? restorationId;
  String? dropdownWalletValue;
  // final int? userid;
  // final KategoriTransaksis? kategoriTransaksiLists;
  // List<KategoriTransaksis>? listKategori = [];
  // final Wallets? walletslists;
  // List<Wallets>? listWallet = [];
  @override
  State<TransaksiApp> createState() => Transaksi();
}

class Transaksi extends State<TransaksiApp> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;
  final RestorableDateTime _selectedDate = RestorableDateTime(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(DateTime.now().year + 1),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  var userid = Userid(0);
  KategoriTransaksis? kategoriTransaksiLists;
  List<KategoriTransaksis> listKategori = [];
  Transaksis? TransaksiLists;
  List<Transaksis> listTransaksi = [];
  Wallets? walletslists;
  var dropdownValue;
  List<Wallets> listWallet = [];

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  TextEditingController nominalTransaksiController = TextEditingController();
  String? get dropdownWalletValue => widget.dropdownWalletValue;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 380;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference transaksi = firestore.collection('transaksi');
    CollectionReference wallet = firestore.collection('wallet');
    String? useremail = (FirebaseAuth.instance.currentUser!.email);
    var curruser = Users;

    var usernow = FirebaseFirestore.instance
        .collection('user')
        .where("email", isEqualTo: useremail)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        setState(() {
          var curruser = Users.fromDocument(docSnapshot);
          userid.index = curruser.id;
        });
        return curruser;
      }
    }, onError: (e) => print("error completing $e"));
    usernow;

    var kategoriTransaksiList = FirebaseFirestore.instance
        .collection('kategoriTransaksi')
        .where("idUser", isEqualTo: userid.index)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        usernow;
        kategoriTransaksiLists = KategoriTransaksis.fromDocument(docSnapshot);
        setState(() {
          var kategoritrans = KategoriTransaksis.fromDocument(docSnapshot);
          listKategori.add(kategoritrans);
          kategoriTransaksiLists?.idKategoriTransaksi =
              kategoritrans.idKategoriTransaksi;
          kategoriTransaksiLists?.idUser = kategoritrans.idUser;
          kategoriTransaksiLists?.namaKategori = kategoritrans.namaKategori;
        });
        return kategoriTransaksiLists;
      }
      listKategori.add(KategoriTransaksis(
          namaKategori: "Create Categories",
          idUser: 0,
          idKategoriTransaksi: 0));
    });
    var TransaksiList = FirebaseFirestore.instance
        .collection('transaksi')
        .where("idUser", isEqualTo: userid.index)
        // .orderBy('created_at')
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        usernow;
        TransaksiLists = Transaksis.fromDocument(docSnapshot);
        setState(() {
          var trans = Transaksis.fromDocument(docSnapshot);
          listTransaksi.add(trans);
          TransaksiLists?.idTransaksi = trans.idTransaksi;
          TransaksiLists?.idKategoriTransaksi = trans.idKategoriTransaksi;
          TransaksiLists?.idUser = trans.idUser;
          TransaksiLists?.keteranganTransaksi = trans.keteranganTransaksi;
          TransaksiLists?.nominal = trans.nominal;
        });
        return TransaksiLists;
      }
      // listTransaksi.add(Transaksis(
      //   keteranganTransaksi: "Create Transacto",
      //   idUser: 0,
      //   idTransaksi: 0,
      //   nominal: 0,
      //   idKategoriTransaksi: 0,
      // ));
    });
    var WalletList = FirebaseFirestore.instance
        .collection('wallet')
        .where("idUser", isEqualTo: userid.index)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        usernow;
        walletslists = Wallets.fromDocument(docSnapshot);
        setState(() {
          var walletlis = Wallets.fromDocument(docSnapshot);
          listWallet.add(walletlis);
          walletslists?.idWallet = walletlis.idWallet;
          walletslists?.idUser = walletlis.idUser;
          walletslists?.namaWallet = walletlis.namaWallet;
        });
        return walletslists;
      }
      listWallet
          .add(Wallets(namaWallet: "Create Wallet", idUser: 0, idWallet: 0));
    });
    kategoriTransaksiList;
    TransaksiList;
    WalletList;

    List<String> mapkategori =
        listKategori.map((nama) => nama.namaKategori).toList();
    var seen = <String>{};
    List<String> uniquelist =
        mapkategori.where((country) => seen.add(country)).toList();
    String dropdownValue = uniquelist.first;
    List<String> mapWallet = listWallet.map((nama) => nama.namaWallet).toList();
    var seenwallet = <String>{};
    List<String> uniquewalletlist =
        mapWallet.where((country) => seenwallet.add(country)).toList();
    if (widget.dropdownWalletValue.runtimeType.toString() == "Null") {
      widget.dropdownWalletValue = uniquewalletlist.first;
    }
    // print(listTransaksi[0].idKategoriTransaksi);
    // var seenTransaksi = Set<String>();
    // print("listWallet $listWallet");
    // print("listTransaksi $listTransaksi");
    // print(listTransaksi);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Container(
          // homepageuUY (113:549)
          width: 380,
          // height: 1007,
          decoration: const BoxDecoration(
            color: Color(0xfff5f7ff),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
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
                                  child: DropdownButton<String>(
                                underline: const SizedBox(),
                                onChanged: (String? value) {
                                  setState(() {
                                    widget.dropdownWalletValue = value;
                                  });
                                  if (dropdownWalletValue == "Create Wallet") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CreateCategoriesApp()));
                                  }
                                },
                                value: dropdownWalletValue,
                                icon: Container(
                                  margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  child: SvgPicture.asset(
                                    'assets/caret-arrow-up.svg',
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                items: uniquewalletlist
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
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
                  )
                ]),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                width: 343,
                height: 90,
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
                    margin: const EdgeInsets.fromLTRB(16, 8, 0, 0),
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
                        SizedBox(
                          width: 80,
                          child: Text(
                            "$dropdownWalletValue".toUpperCase(),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff2C3235),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 256,
                    height: 49,
                    margin: const EdgeInsets.fromLTRB(16, 12, 141, 0),
                    child: Column(children: [
                      Container(
                        width: 101,
                        height: 13,
                        margin: const EdgeInsets.fromLTRB(0, 0, 85, 8),
                        child: const Text(
                          "Total Kredit",
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
                margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                // howmuchdoyouwantJGt (115:999)
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 139,
                    height: 20,
                    child: Text(
                      'Laporan Kredit',
                      style: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.4000000272,
                        letterSpacing: -0.200000003,
                        color: Color(0xff5c616f),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 343,
                height: 306,
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  ),
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
                                color: Color.fromARGB(255, 0, 68, 255),
                                offset: Offset(0, 4),
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
                                color: Color.fromARGB(255, 255, 255, 255),
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
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
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
                                  margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
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
                                  margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
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
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
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
                                        'Debit',
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
                                  margin: const EdgeInsets.fromLTRB(0, 4, 4, 0),
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
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
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
                                        'Kredit',
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
                                  margin: const EdgeInsets.fromLTRB(0, 4, 4, 0),
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
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
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
                                  margin: const EdgeInsets.fromLTRB(0, 4, 4, 0),
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
                // frame20543vtc (117:2886)
                child: SizedBox(
                  width: 360,
                  height: 42,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // howmuchdoyouwantFR6 (117:2829)
                        margin: const EdgeInsets.fromLTRB(20, 0, 100, 0),
                        child: const Text(
                          'Transaksi Terbaru',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.4000000272,
                            letterSpacing: -0.200000003,
                            color: Color(0xff5c616f),
                          ),
                        ),
                      ),
                      Container(
                        // frame166MDE (117:2887)
                        margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                        // padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                        // height: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // lihatsemuaFpQ (117:2890)
                              margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              height: 17,
                              child: const Text(
                                'Lihat Semua',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3999999364,
                                  color: Color(0xff2c14dd),
                                ),
                              ),
                            ),
                            Container(
                                // iconmnk (117:2888)
                                width: 2,
                                height: 17,
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 17),
                                // height: 40,
                                child: IconButton(
                                  iconSize: 16,
                                  icon: const Icon(Icons.arrow_forward_ios),
                                  onPressed: () {},
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                // cardsmallZCp (117:2830)
                child: Container(
                  // padding: EdgeInsets.fromLTRB(16, 0, 12, 0),
                  width: 343,
                  height: 159,
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
                          itemCount: listTransaksi.length,
                          itemBuilder: (BuildContext context, int index) {
                            var transaksis = listTransaksi[index];
                            return ListTransaksiCard(
                                transaksis.keteranganTransaksi,
                                transaksis.nominal.toString(),
                                transaksis.WaktuTransaksi,
                                1);
                          },
                        )))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
            height: 40,
            width: 40,
            child: FittedBox(
              child: FloatingActionButton(
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
