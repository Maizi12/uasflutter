// import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uas_flutter/beranda.dart';
import 'package:uas_flutter/createCategory.dart';
import 'package:uas_flutter/createWallet.dart';
import 'package:uas_flutter/models/kategori.dart';
import 'package:uas_flutter/models/user.dart';
import 'package:uas_flutter/models/wallet.dart';

import 'models/kategori.dart';

const List<String> wallet = <String>[
  'One',
  'Two',
  'Three',
  'Four',
  'Create Wallet'
];

class Userid {
  int index;
  Userid(this.index);
}

class TransaksiApp extends StatefulWidget {
  TransaksiApp({
    super.key,
    this.restorationId,
    this.userid,
    this.kategoriTransaksiLists,
    this.listKategori,
    this.walletslists,
    this.listWallet,
    this.dropdownValue,
  });
  final String? restorationId;
  final int? userid;
  final KategoriTransaksis? kategoriTransaksiLists;
  List<KategoriTransaksis>? listKategori = [];
  final Wallets? walletslists;
  List<Wallets>? listWallet = [];
  final String? dropdownValue;
  @override
  State<TransaksiApp> createState() => Transaksi();
}

class Transaksi extends State<TransaksiApp> with RestorationMixin {
  var userid = Userid(0);
  KategoriTransaksis? kategoriTransaksiLists;
  List<KategoriTransaksis> listKategori = [];
  Wallets? walletslists;
  var dropdownValue;
  List<Wallets> listWallet = [];
  @override
  void initstate() {
    super.initState();
  }

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

  // String dropdownWalletValue = wallet.first;
  TextEditingController nominalTransaksiController = TextEditingController();
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference transaksi = firestore.collection('transaksi');
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
    String dropdownWalletValue = uniquewalletlist.first;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => Beranda()))),
        title: const Text('UAS'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) Navigator.of(context).pop();
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
          color: Colors.cyan,
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Container(),
            Container(
              width: 600,
              height: 200,
              child: DropdownButtonFormField<String>(
                items: uniquelist.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                // onSaved: (String? value) {
                //   setState(() {
                //     dropdownValue = value!;
                //   });
                //   print("onSaved dropdown");
                //   print(dropdownValue);
                // },
                value: dropdownValue,
                onChanged: (String? value) {
                  // print("onChanged dropdownValue");
                  // // This is called when the user selects an item.
                  dropdownValue = value!;
                  // print(dropdownValue);
                  setState(() {
                    dropdownValue = value!;
                    // dropdownValue;
                  });
                  if (dropdownValue.toString() == "Create Categories") {
                    print("if" + dropdownValue);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateCategoriesApp()));
                  }
                },
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                // underline: Container(
                //   height: 2,
                //   color: Colors.deepPurpleAccent,
                // ),
              ),
            ),
            Container(
              child: OutlinedButton(
                onPressed: () {
                  _restorableDatePickerRouteFuture.present();
                },
                child: Builder(
                  builder: (context) {
                    if (_selectedDate != "") {
                      return Text(
                          DateFormat('yyyy-MM-dd').format(_selectedDate.value));
                    } else {
                      return Text('Open Date Picker');
                    }
                  },
                ),
              ),
            ),
            Container(
              width: 600,
              height: 200,
              child: DropdownButtonFormField<String>(
                onSaved: (String? value) {
                  setState(() {
                    dropdownWalletValue = value!;
                    dropdownWalletValue;
                  });
                },
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownWalletValue = value!;
                  });
                  if (dropdownWalletValue.toString() == "Create Wallet") {
                    print("if" + dropdownWalletValue);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateWalletApp()));
                  }
                },
                value: dropdownWalletValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                // underline: Container(
                //   height: 2,
                //   color: Colors.deepPurpleAccent,
                // ),
                items: uniquewalletlist
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: nominalTransaksiController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nominal Transaksi',
                    ),
                  ),
                ]),
            SizedBox(
                child: ElevatedButton(
              onPressed: () async {
                print(dropdownValue);
                int idkategori = 0;
                for (var a in listKategori) {
                  if (a.namaKategori == dropdownValue) {
                    idkategori = a.idKategoriTransaksi;
                  }
                }
                print("idkategori");
                print(idkategori);
                transaksi.add({
                  'idTransaksi': FieldValue.increment(1),
                  'idKategoriTransaksi': idkategori,
                  'idUser': userid,
                  'idWallet': 1,
                  'waktuTransaksi':
                      DateFormat('yyyy-MM-dd').format(_selectedDate.value),
                  'nominal': nominalTransaksiController.text,
                }).then(
                    (value) => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Success"),
                              content: Text("Transaksi berhasil ditambahkan!!"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TransaksiApp()));
                                  },
                                  child: Text("OK"),
                                )
                              ],
                            )),
                    onError: (e) => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Error"),
                              content: Text("Error updating document $e"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                )
                              ],
                            )));
              },
              child: Text("Tambahkan"),
            )),
          ])),
      bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: Row(children: [
            Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  SizedBox(
                      width: 100,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/icons8-home (1).svg',
                          height: 30,
                          width: 100,
                        ),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Overview',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 10,
                        fontFamily: 'SF Pro Rounded',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ])),
            Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  SizedBox(
                      width: 100,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => JadwalKuliah()));
                        },
                        child: SvgPicture.asset(
                          'assets/icons8-clock.svg',
                          height: 30,
                          width: 100,
                        ),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Budgeting',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 10,
                        fontFamily: 'SF Pro Rounded',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ])),
            Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Profil()));
                        },
                        child:
                            Image.asset("assets/icons8-male-user-50(1).png")),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Tools',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 10,
                        fontFamily: 'SF Pro Rounded',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ]))
          ])),
    );
  }
}
