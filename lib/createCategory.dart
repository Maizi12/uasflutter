import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas_flutter/transaksi.dart';

const List<String> list = <String>['Debit', 'Kredit'];

class CreateCategoriesApp extends StatefulWidget {
  const CreateCategoriesApp({super.key});
  @override
  State<CreateCategoriesApp> createState() => CreateCategory();
}

class CreateCategories {
  // final User user;
  final String message;
  // CreateCategories({required this.user, required this.message});
  CreateCategories({required this.message});
}

class CreateCategory extends State<CreateCategoriesApp> {
  String dropdownValue = list.first;
  var user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    TextEditingController namaKategoriController = TextEditingController();
    CollectionReference kategoriTransaksi =
        firestore.collection('kategoriTransaksi');
    CollectionReference user = firestore.collection('user');
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
              icon: const Icon(Icons.logout),
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
                      controller: namaKategoriController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nama Kategori',
                      ),
                    ),
                  ])),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 500,
            height: 51,
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
              child: ElevatedButton(
            onPressed: () async {
              kategoriTransaksi.add({
                'namaKategori': namaKategoriController.text,
                'debitKredit': dropdownValue,
                'idKategoriTransaksi': FieldValue.increment(1),
                'idUser': user.id,
              }).then(
                  (value) => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Success"),
                            content:
                                const Text("DocumentSnapshot successfully updated!"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TransaksiApp()));
                                },
                                child: const Text("OK"),
                              )
                            ],
                          )),
                  onError: (e) => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Error"),
                            content: Text("Error updating document $e"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              )
                            ],
                          )));
            },
            child: const Text("Tambahkan"),
          ))
        ]));
  }
}

void showNotification(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.orange.shade900,
      content: Text(message.toString())));
}
