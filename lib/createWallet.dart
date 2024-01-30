import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_flutter/transaksi.dart';

class CreateWalletApp extends StatefulWidget {
  const CreateWalletApp({super.key});
  @override
  State<CreateWalletApp> createState() => CreateWallet();
}

class CreateWallets {
  // final User user;
  final String message;
  // CreateWallet({required this.user, required this.message});
  CreateWallets({required this.message});
}

class CreateWallet extends State<CreateWalletApp> {
  String dropdownValue = list.first;
  var user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    TextEditingController namaWalletController = TextEditingController();
    CollectionReference wallet = firestore.collection('wallet');
    return Scaffold(
        appBar: AppBar(
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
        body: Column(children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
              width: 500,
              height: 51,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: namaWalletController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nama Wallet',
                      ),
                    ),
                  ])),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
              child: ElevatedButton(
            onPressed: () async {
              wallet.add({
                'namaWallet': namaWalletController.text,
                'idUser': 1,
                'idWallet': FieldValue.increment(1),
                'saldo': 0,
                'transaksiKeluar': 0,
                'transaksiMasuk': 0
              }).then(
                  (value) => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Success"),
                            content: Text("Wallet berhasil ditambahkan!!"),
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
          ))
        ]));
  }
}

void showNotification(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orange.shade900,
      content: Text(message.toString())));
}
