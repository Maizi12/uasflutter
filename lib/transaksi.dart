// import 'dart:ffi';

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uas_flutter/createCategory.dart';
import 'package:uas_flutter/models/kategori.dart';
import 'package:uas_flutter/models/user.dart';
import 'package:uas_flutter/models/wallet.dart';
import 'package:uas_flutter/models/transaksi.dart';
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
    var seen = Set<String>();
    List<String> uniquelist =
        mapkategori.where((country) => seen.add(country)).toList();
    String dropdownValue = uniquelist.first;
    List<String> mapWallet = listWallet.map((nama) => nama.namaWallet).toList();
    var seenwallet = Set<String>();
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
      body: Container(
        // homepageuUY (113:549)
        width: double.infinity,
        height: 977,
        decoration: BoxDecoration(
          color: Color(0xfff5f7ff),
        ),
        child: Stack(
          children: [
            // Positioned(
            //   // statusbarxxc (115:827)
            //   left: 31.3939208984,
            //   top: 14,
            //   child: Container(
            //     width: 329.11,
            //     height: 18,
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Container(
            //           // timeDtY (115:829)
            //           margin: EdgeInsets.fromLTRB(0, 0, 231.11, 0),
            //           child: Text(
            //             '9:41',
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //               fontFamily: 'Inter',
            //               fontSize: 15,
            //               fontWeight: FontWeight.w600,
            //               height: 1.2,
            //               letterSpacing: -0.1650000066,
            //               color: Color(0xff161719),
            //             ),
            //           ),
            //         ),
            //         Container(
            //           // containerrwW (115:830)
            //           margin: EdgeInsets.fromLTRB(0, 2.16, 0, 4.34),
            //           height: double.infinity,
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Container(
            //                 // combinedshapePAk (115:838)
            //                 margin: EdgeInsets.fromLTRB(0, 0.08, 5, 0),
            //                 width: 17.1,
            //                 height: 10.7,
            //                 child: Image.network(
            //                   "google.com",
            //                   width: 17.1,
            //                   height: 10.7,
            //                 ),
            //               ),
            //               Container(
            //                 // wifi5pG (115:843)
            //                 margin: EdgeInsets.fromLTRB(0, 0.04, 5, 0),
            //                 width: 15.4,
            //                 height: 11.06,
            //                 child: Image.network(
            //                   "google.com",
            //                   width: 15.4,
            //                   height: 11.06,
            //                 ),
            //               ),
            //               Container(
            //                 // batterybnc (115:831)
            //                 width: 24.5,
            //                 height: 11.5,
            //                 child: Image.network(
            //                   "google.com",
            //                   width: 24.5,
            //                   height: 11.5,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Positioned(
              // balancevK6 (115:918)
              left: 20,
              top: 53,
              child: Container(
                width: 419,
                height: 74,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // frame20103EKn (115:920)
                      margin: EdgeInsets.fromLTRB(0, 0, 129, 0),
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // frame20532MvC (116:2554)
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
                            padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // frame204Jp (116:2555)
                                  margin: EdgeInsets.fromLTRB(0, 0, 8, 1),
                                  width: 18,
                                  height: 18,
                                  child: SvgPicture.asset(
                                    'assets/Logo.svg',
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                                Container(
                                  // secondarytextAse (115:921)
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Text(
                                    '$dropdownWalletValue',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 1.26,
                                      letterSpacing: -0.1679999924,
                                      color: Color(0xff131313),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    child: DropdownButton<String>(
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
                                                  CreateCategoriesApp()));
                                    }
                                  },
                                  value: dropdownWalletValue,
                                  icon: Icon(Icons.arrow_drop_down_circle),
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
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
                          Text(
                            // subtitle1Xbi (115:922)
                            'Keuangan Kamu Terlihat Sehat',
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              color: Color(0xff5c616f),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // iconbackFnc (115:919)
                      margin: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        // iconlyboldnotificationxS8 (115:894)
                        child: SizedBox(
                            width: 24,
                            height: 24,
                            child: IconButton(
                              iconSize: 24,
                              icon: Icon(Icons.notifications),
                              onPressed: () {},
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // pengeluaranEuS (115:950)
              left: 16,
              top: 124,
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                width: 343,
                height: 107,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3fe7e7e7),
                      offset: Offset(0, 4),
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // frame4gFe (116:2561)
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                      width: double.infinity,
                      height: 14,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // daribdW (116:2562)
                            margin: EdgeInsets.fromLTRB(0, 0, 210, 0),
                            child: Text(
                              'Dari',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                color: Color(0xff131313),
                              ),
                            ),
                          ),
                          Container(
                            // frame20533J28 (116:2576)
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // frame203Ec (116:2570)
                                  margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                                  width: 12,
                                  height: 12,
                                  child: SvgPicture.asset(
                                    'assets/Logo.svg',
                                    height: 12,
                                    width: 12,
                                  ),
                                ),
                                Text(
                                  // dompetsayaYhA (116:2563)
                                  '$dropdownWalletValue',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4,
                                    color: Color(0xff2c3235),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogrouph2usH8x (GyfTE4o8uEAiExGzTrh2uS)
                      width: double.infinity,
                      height: 49,
                      child: Container(
                        // frame20529cwv (115:961)
                        width: 151,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // labelZMN (115:960)
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: Text(
                                'Total Pengeluaran',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  height: 1.26,
                                  color: Color(0xff5c616f),
                                ),
                              ),
                            ),
                            Container(
                              // frame20528ffJ (115:952)
                              width: double.infinity,
                              height: 28,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // secondarytextomW (115:953)
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Rp 5,200,00',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        height: 1.4,
                                        color: Color(0xff161719),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      // eye11hrt (115:954)
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      // width: 16,
                                      // height: 9.54,
                                      child: IconButton(
                                        icon:
                                            Icon(Icons.remove_red_eye_outlined),
                                        onPressed: () {},
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // autogroupgqgu1cg (GyfP3rRPgo7arPQDsaGQgU)
              left: 16,
              top: 287,
              child: Container(
                width: 343,
                height: 380,
                child: Stack(
                  children: [
                    Positioned(
                      // pengeluaranvDr (115:982)
                      left: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 63),
                        width: 343,
                        height: 377,
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3fe7e7e7),
                              offset: Offset(0, 4),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // tabscontainermkG (115:1053)
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 22),
                              padding: EdgeInsets.fromLTRB(4, 4, 4, 0),
                              width: double.infinity,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Color(0xfff2f4f5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                // activesectionviewboxf4x (115:1054)
                                width: double.infinity,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // activesectionaxc (115:1056)
                                      left: 0,
                                      top: 0,
                                      child: Align(
                                        child: SizedBox(
                                          width: 150,
                                          height: 34,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Color(0xffffffff),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x0c000000),
                                                  offset: Offset(0, 1),
                                                  blurRadius: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // rightpaddingrfE (115:1057)
                                      left: 150,
                                      top: 0,
                                      child: Align(
                                        child: SizedBox(
                                          width: 153,
                                          height: 40,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x0c000000),
                                                  offset: Offset(0, 1),
                                                  blurRadius: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // tabssectionLaQ (115:1058)
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 303,
                                        height: 34,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // xsegmentedcontrolitemroe (115:1059)
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 4, 0),
                                              width: 149.5,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0x0c000000),
                                                    offset: Offset(0, 2),
                                                    blurRadius: 2,
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Center(
                                                  child: Text(
                                                    'Mingguan',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Plus Jakarta Sans',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.26,
                                                      color: Color(0xff131313),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              // xsegmentedcontrolitemGsN (115:1060)
                                              onPressed: () {},
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                              ),
                                              child: Container(
                                                width: 149.5,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: Center(
                                                    child: Text(
                                                      'Bulanan',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 1.26,
                                                        color:
                                                            Color(0xff5c616f),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              // frame20541KKr (117:2790)
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    // dataTBA (117:2707)
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                                    width: 303,
                                    height: 181,
                                    child: Container(
                                      // group16Bsr (117:2708)
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 303,
                                            height: 162,
                                            // child:
                                            // Echarts(
                                            //   option: '''
                                            //     {
                                            //       xAxis: {
                                            //         type: 'category',
                                            //         data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                                            //       },
                                            //       yAxis: {
                                            //         type: 'value'
                                            //       },
                                            //       series: [{
                                            //         data: [820, 932, 901, 934, 1290, 1330, 1320],
                                            //         type: 'line'
                                            //       }]
                                            //     }
                                            //   ''',
                                            // ),
                                          ),
                                          Container(
                                            // path5copy3QG (117:2719)
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 2),
                                            width: 296,
                                            height: 1,
                                            // child: Image.network(
                                            //   "google.com",
                                            //   width: 296,
                                            //   height: 1,
                                            // ),
                                          ),
                                          Container(
                                            // group59y6 (117:2709)
                                            height: 16,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // janHZW (117:2710)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 22, 0),
                                                  child: Text(
                                                    'Sun',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito Sans',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3625,
                                                      letterSpacing:
                                                          0.1843809634,
                                                      color: Color(0xff83899b),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  // febNL4 (117:2711)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 22, 0),
                                                  child: Text(
                                                    'Mon',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito Sans',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3625,
                                                      letterSpacing:
                                                          0.1843809634,
                                                      color: Color(0xff83899b),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  // mart3W (117:2712)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 28, 0),
                                                  child: Text(
                                                    'Tue',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito Sans',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3625,
                                                      letterSpacing:
                                                          0.1843809634,
                                                      color: Color(0xff83899b),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  // aprneg (117:2713)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 20, 0),
                                                  child: Text(
                                                    'Wed',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito Sans',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3625,
                                                      letterSpacing:
                                                          0.1843809634,
                                                      color: Color(0xff83899b),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  // mayuUQ (117:2714)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 28, 0),
                                                  child: Text(
                                                    'Thu',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito Sans',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3625,
                                                      letterSpacing:
                                                          0.1843809634,
                                                      color: Color(0xff83899b),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  // junQvx (117:2715)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 25, 0),
                                                  child: Text(
                                                    'Fri',
                                                    style: TextStyle(
                                                      fontFamily: 'Nunito Sans',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3625,
                                                      letterSpacing:
                                                          0.1843809634,
                                                      color: Color(0xff83899b),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  // julTPS (117:2716)
                                                  'Sat',
                                                  style: TextStyle(
                                                    fontFamily: 'Nunito Sans',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.3625,
                                                    letterSpacing: 0.1843809634,
                                                    color: Color(0xff83899b),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // legendaz8U (117:2774)
                                    margin: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                    height: 35,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // frame20538umE (117:2775)
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 20, 0),
                                          width: 89,
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // frame20537c9r (117:2776)
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 22, 4),
                                                width: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // oval8P6 (117:2777)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 4, 0),
                                                      width: 8,
                                                      height: 8,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff1fde00)),
                                                        color:
                                                            Color(0xffffffff),
                                                      ),
                                                    ),
                                                    Text(
                                                      // shoppingS8t (117:2778)
                                                      'Pemasukan',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.26,
                                                        color:
                                                            Color(0xff83899b),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // secondarytextmBA (117:2779)
                                                width: double.infinity,
                                                child: Text(
                                                  'Rp 17,000,000',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.5,
                                                    color: Color(0xff161719),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // frame20539UrG (117:2780)
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 25, 0),
                                          width: 84,
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // frame20537Qjv (117:2781)
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 12, 4),
                                                width: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // oval8A8 (117:2782)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 4, 0),
                                                      width: 8,
                                                      height: 8,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xffff4040)),
                                                        color:
                                                            Color(0xffffffff),
                                                      ),
                                                    ),
                                                    Text(
                                                      // shoppingq4Y (117:2783)
                                                      'Pengeluaran',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.26,
                                                        color:
                                                            Color(0xff83899b),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // secondarytextZWL (117:2784)
                                                width: double.infinity,
                                                child: Text(
                                                  'Rp 2,500,000',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.5,
                                                    color: Color(0xff161719),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // frame20540V96 (117:2785)
                                          width: 90,
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // frame20537RYY (117:2786)
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 45, 4),
                                                width: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // ovalMh6 (117:2787)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 4, 0),
                                                      width: 8,
                                                      height: 8,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color:
                                                            Color(0xffffffff),
                                                        border: Border(),
                                                      ),
                                                    ),
                                                    Text(
                                                      // shopping4bW (117:2788)
                                                      'Tersisa',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.26,
                                                        color:
                                                            Color(0xff83899b),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // secondarytextoZ6 (117:2789)
                                                width: double.infinity,
                                                child: Text(
                                                  'Rp 14,500,000',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.5,
                                                    color: Color(0xff161719),
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
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // frame20543vtc (117:2886)
                      left: 0,
                      top: 360,
                      child: Container(
                        width: 343,
                        height: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // howmuchdoyouwantFR6 (117:2829)
                              margin: EdgeInsets.fromLTRB(0, 0, 140, 0),
                              child: Text(
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
                              margin: EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                              padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // lihatsemuaFpQ (117:2890)
                                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Text(
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
                                      width: 4,
                                      height: 8,
                                      child: IconButton(
                                        icon: Icon(Icons.arrow_forward_ios),
                                        onPressed: () {},
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // howmuchdoyouwantJGt (115:999)
              left: 16,
              top: 255,
              child: Align(
                child: SizedBox(
                  width: 139,
                  height: 20,
                  child: Text(
                    'Laporan Pengeluaran',
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
            Positioned(
              // cardsmallZCp (117:2830)
              left: 16,
              top: 679,
              child: Container(
                padding: EdgeInsets.fromLTRB(16, 16, 24, 15),
                width: 343,
                height: 191,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3fe7e7e7),
                      offset: Offset(0, 4),
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Container(
                  // frame1950dCg (117:2831)
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: SizedBox(
                              child: ListView.builder(
                        itemCount: listTransaksi.length,
                        itemBuilder: (BuildContext context, int index) {
                          var transaksis = listTransaksi[index];
                          return ListTransaksiCard(
                              transaksis.keteranganTransaksi,
                              transaksis.nominal.toString(),
                              transaksis.WaktuTransaksi);
                          // return Container(
                          //   // frame305mZn (117:2832)
                          //   width: double.infinity,
                          //   height: 38,
                          //   child: Row(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: ListTransaksiCard(transaksis.keteranganTransaksi,
                          //           transaksis.nominal as String, transaksis.WaktuTransaksi)

                          // [

                          //   Container(
                          //     // frame2777Nk (117:2833)
                          //     margin: EdgeInsets.fromLTRB(0, 0.5, 12, 1.5),
                          //     width: 36,
                          //     height: double.infinity,
                          //     decoration: BoxDecoration(
                          //       color: Color(0xffeef2f8),
                          //       borderRadius: BorderRadius.circular(100),
                          //     ),
                          //     child: Center(
                          //       child: Text(
                          //         'F',
                          //         style: TextStyle(
                          //           fontFamily: 'Plus Jakarta Sans',
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w600,
                          //           height: 1.26,
                          //           color: Color(0xff2c14dd),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          //   Container(
                          //     // frame305miC (117:2835)
                          //     margin: EdgeInsets.fromLTRB(0, 0, 63, 0),
                          //     height: double.infinity,
                          //     child: Column(
                          //       crossAxisAlignment:
                          //           CrossAxisAlignment.start,
                          //       children: [
                          //         Container(
                          //           // titleVu6 (117:2836)
                          //           margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                          //           child: Text(
                          //             '$listTransaksi[$index].keteranganTransaksi',
                          //             style: TextStyle(
                          //               fontFamily: 'Plus Jakarta Sans',
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.w500,
                          //               height: 1.26,
                          //               color: Color(0xff131313),
                          //             ),
                          //           ),
                          //         ),
                          //         Text(
                          //           // titlecyi (117:2837)
                          //           '31 Januari 2024',
                          //           style: TextStyle(
                          //             fontFamily: 'Plus Jakarta Sans',
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.w400,
                          //             height: 1.26,
                          //             color: Color(0xff131313),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          //   Container(
                          //     // titleNCC (117:2838)
                          //     margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                          //     child: Text(
                          //       '$listTransaksi[$index].nominal',
                          //       textAlign: TextAlign.right,
                          //       style: TextStyle(
                          //         fontFamily: 'Plus Jakarta Sans',
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.w600,
                          //         height: 1.26,
                          //         color: Color(0xff1fde00),
                          //       ),
                          //     ),
                          //   ),
                          // ],
                          // ),
                          // );
                          // SizedBox(
                          //   height: 23,
                          // ),
                        },
                        // children: [
                        //   Container(
                        //     // frame310Shr (117:2867)
                        //     width: double.infinity,
                        //     height: 38,
                        //     child: Row(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Container(
                        //           // frame277BvL (117:2868)
                        //           margin:
                        //               EdgeInsets.fromLTRB(0, 0.5, 12, 1.5),
                        //           width: 36,
                        //           height: double.infinity,
                        //           decoration: BoxDecoration(
                        //             color: Color(0xffeef2f8),
                        //             borderRadius: BorderRadius.circular(100),
                        //           ),
                        //           child: Center(
                        //             child: Text(
                        //               'G',
                        //               style: TextStyle(
                        //                 fontFamily: 'Plus Jakarta Sans',
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.w600,
                        //                 height: 1.26,
                        //                 color: Color(0xff2c14dd),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         Container(
                        //           // frame305e3E (117:2870)
                        //           margin: EdgeInsets.fromLTRB(0, 0, 71, 0),
                        //           height: double.infinity,
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Container(
                        //                 // titleAXN (117:2871)
                        //                 margin:
                        //                     EdgeInsets.fromLTRB(0, 0, 0, 4),
                        //                 child: Text(
                        //                   'Gajian',
                        //                   style: TextStyle(
                        //                     fontFamily: 'Plus Jakarta Sans',
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.w500,
                        //                     height: 1.26,
                        //                     color: Color(0xff131313),
                        //                   ),
                        //                 ),
                        //               ),
                        //               Text(
                        //                 // titleUHA (117:2872)
                        //                 '31 Januari 2024',
                        //                 style: TextStyle(
                        //                   fontFamily: 'Plus Jakarta Sans',
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.w400,
                        //                   height: 1.26,
                        //                   color: Color(0xff131313),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         Container(
                        //           // titleQwW (117:2873)
                        //           margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                        //           child: Text(
                        //             'Rp 7,000,000',
                        //             textAlign: TextAlign.right,
                        //             style: TextStyle(
                        //               fontFamily: 'Plus Jakarta Sans',
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.w600,
                        //               height: 1.26,
                        //               color: Color(0xff1fde00),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        //   SizedBox(
                        //     height: 23,
                        //   ),
                        //   Container(
                        //     // frame311trg (117:2874)
                        //     width: double.infinity,
                        //     height: 38,
                        //     child: Row(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Container(
                        //           // frame277EvY (117:2875)
                        //           margin:
                        //               EdgeInsets.fromLTRB(0, 0.5, 12, 1.5),
                        //           width: 36,
                        //           height: double.infinity,
                        //           decoration: BoxDecoration(
                        //             color: Color(0xffeef2f8),
                        //             borderRadius: BorderRadius.circular(100),
                        //           ),
                        //           child: Center(
                        //             child: Text(
                        //               'T',
                        //               style: TextStyle(
                        //                 fontFamily: 'Plus Jakarta Sans',
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.w600,
                        //                 height: 1.26,
                        //                 color: Color(0xff2c14dd),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         Container(
                        //           // frame305XPr (117:2877)
                        //           margin: EdgeInsets.fromLTRB(0, 0, 73, 0),
                        //           height: double.infinity,
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Container(
                        //                 // titleToJ (117:2878)
                        //                 margin:
                        //                     EdgeInsets.fromLTRB(0, 0, 0, 4),
                        //                 child: Text(
                        //                   'Top Up',
                        //                   style: TextStyle(
                        //                     fontFamily: 'Plus Jakarta Sans',
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.w500,
                        //                     height: 1.26,
                        //                     color: Color(0xff131313),
                        //                   ),
                        //                 ),
                        //               ),
                        //               Text(
                        //                 // titleBDW (117:2879)
                        //                 '30 Januari 2024',
                        //                 style: TextStyle(
                        //                   fontFamily: 'Plus Jakarta Sans',
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.w400,
                        //                   height: 1.26,
                        //                   color: Color(0xff131313),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //         Container(
                        //           // titleKac (117:2880)
                        //           margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                        //           child: Text(
                        //             'Rp 2,500,000',
                        //             textAlign: TextAlign.right,
                        //             style: TextStyle(
                        //               fontFamily: 'Inter',
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.w500,
                        //               height: 1.2125,
                        //               color: Color(0xffff4040),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ]
                      )))
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              // tabbar2zp (113:627)
              left: 0,
              top: 891,
              child: Container(
                padding: EdgeInsets.fromLTRB(40.33, 8, 51.33, 8),
                width: 375,
                height: 86,
                decoration: BoxDecoration(
                  color: Color(0xccffffff),
                ),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 8,
                      sigmaY: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // tabsG8U (113:628)
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 21),
                          width: double.infinity,
                          height: 44,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // tab1aex (114:675)
                                margin: EdgeInsets.fromLTRB(0, 0, 70.17, 0),
                                padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // option1t9r (114:682)
                                      margin:
                                          EdgeInsets.fromLTRB(0.33, 0, 0, 7),
                                      width: 18,
                                      height: 18,
                                      child: SvgPicture.asset(
                                        'assets/Overview.svg',
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                    Center(
                                      // titleyh6 (114:679)
                                      child: Text(
                                        'Overview',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3333333333,
                                          color: Color(0xff2c14dd),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // tab572c (114:691)
                                margin: EdgeInsets.fromLTRB(0, 0, 81.17, 0),
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // iconlylightwalletF8p (114:798)
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                      width: 24,
                                      height: 24,
                                      child: SvgPicture.asset(
                                        'assets/Wallet.svg',
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                    Center(
                                      // titleLvx (114:695)
                                      child: Text(
                                        'Budget',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3333333333,
                                          color: Color(0xff64748b),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // tab457r (114:703)
                                height: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        // iconlylightsettingRSc (114:805)
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                        width: 24,
                                        height: 24,
                                        child: IconButton(
                                          icon: Icon(Icons.settings_rounded),
                                          onPressed: () {},
                                        )),
                                    Center(
                                      // title7aL (114:707)
                                      child: Text(
                                        'Tools ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3333333333,
                                          color: Color(0xff64748b),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // homeindicatorqFS (I113:634;1205:702)
                          margin: EdgeInsets.fromLTRB(80.67, 0, 68.67, 0),
                          width: double.infinity,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xff0f172a),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // plusj5v (115:824)
              left: 319,
              top: 835,
              child: Align(
                child: SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: Icon(Icons.add_circle),
                      onPressed: () {},
                    )),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //     color: Colors.blue,
      //     child: Row(children: [
      //       Expanded(
      //           child: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //             SizedBox(
      //                 width: 100,
      //                 height: 30,
      //                 child: GestureDetector(
      //                   onTap: () {},
      //                   child: SvgPicture.asset(
      //                     'assets/icons8-home (1assets/).svg',
      //                     height: 30,
      //                     width: 100,
      //                   ),
      //                 )),
      //             const SizedBox(
      //               height: 8,
      //             ),
      //             const SizedBox(
      //               width: double.infinity,
      //               child: Text(
      //                 'Overview',
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   color: Color.fromARGB(255, 255, 255, 255),
      //                   fontSize: 10,
      //                   fontFamily: 'SF Pro Rounded',
      //                   fontWeight: FontWeight.w600,
      //                   height: 0,
      //                 ),
      //               ),
      //             ),
      //           ])),
      //       Expanded(
      //           child: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //             SizedBox(
      //                 width: 100,
      //                 height: 30,
      //                 child: GestureDetector(
      //                   onTap: () {
      //                     // Navigator.push(
      //                     //     context,
      //                     //     MaterialPageRoute(
      //                     //         builder: (context) => JadwalKuliah()));
      //                   },
      //                   child: SvgPicture.asset(
      //                     'assets/icons8-assets/clock.svg',
      //                     height: 30,
      //                     width: 100,
      //                   ),
      //                 )),
      //             const SizedBox(
      //               height: 8,
      //             ),
      //             const SizedBox(
      //               width: double.infinity,
      //               child: Text(
      //                 'Budgeting',
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   color: Color.fromARGB(255, 0, 0, 0),
      //                   fontSize: 10,
      //                   fontFamily: 'SF Pro Rounded',
      //                   fontWeight: FontWeight.w600,
      //                   height: 0,
      //                 ),
      //               ),
      //             ),
      //           ])),
      //       Expanded(
      //           child: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //             SizedBox(
      //               width: 100,
      //               height: 30,
      //               child: GestureDetector(
      //                   onTap: () {
      //                     // Navigator.push(
      //                     //     context,
      //                     //     MaterialPageRoute(
      //                     //         builder: (context) => Profil()));
      //                   },
      //                   child:
      //                       Image.asset("assets/icons8-male-user-50(1).png")),
      //             ),
      //             const SizedBox(
      //               height: 8,
      //             ),
      //             const SizedBox(
      //               width: double.infinity,
      //               child: Text(
      //                 'Tools',
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   color: Color.fromARGB(255, 0, 0, 0),
      //                   fontSize: 10,
      //                   fontFamily: 'SF Pro Rounded',
      //                   fontWeight: FontWeight.w600,
      //                   height: 0,
      //                 ),
      //               ),
      //             ),
      //           ]))
      //     ])),
    );
  }
}
