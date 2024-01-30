import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uas_flutter/createCategory.dart';

const List<String> list = <String>[
  'One',
  'Two',
  'Three',
  'Four',
  'Create Categories'
];

class TransaksiApp extends StatefulWidget {
  const TransaksiApp({super.key});
  @override
  State<TransaksiApp> createState() => Transaksi();
}

class Transaksi extends State<TransaksiApp> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
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
      body: Container(
          color: Colors.cyan,
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 600,
              height: 200,
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
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                  print(dropdownValue);
                  if (dropdownValue.toString() == "Create Categories") {
                    print("if" + dropdownValue);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateCategoriesApp()));
                  }
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )
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
