import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uas_flutter/transaksi.dart';

import 'models/user.dart';

class WelcomeApp extends StatefulWidget {
  WelcomeApp({
    this.namaUser,
  });
  String? namaUser;
  // final int? userid;
  @override
  State<WelcomeApp> createState() => Welcome();
}

class Welcome extends State<WelcomeApp> {
  // late int userid;
  late String namaUser;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference user = firestore.collection('user');
    // print(FirebaseAuth.instance.currentUser!.email);
    String? useremail = (FirebaseAuth.instance.currentUser!.email);
    var curruser = Users;
    var usernow = FirebaseFirestore.instance
        .collection('user')
        .where("email", isEqualTo: useremail)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        var curruser = Users.fromDocument(docSnapshot);
        setState(() {
          widget.namaUser = curruser.namaUser;
          namaUser = curruser.namaUser;
        });
        return curruser;
      }
    }, onError: (e) => print("error completing $e"));
    usernow;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 184, 16, 8),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(78.5, 0, 77.5, 243.17),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(32.06, 0, 32.06, 56),
                    padding: EdgeInsets.fromLTRB(29.74, 37.92, 23.93, 29.24),
                    width: double.infinity,
                    child: Center(
                      child: SizedBox(
                        width: 69.22,
                        height: 55.67,
                        child: Image.asset(
                          'assets/glossy.png',
                          width: 69.22,
                          height: 55.67,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 187,
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          height: 1.3333333333,
                          color: Color(0xff240f51),
                        ),
                        children: [
                          TextSpan(
                            text: 'Hi $namaUser! ',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              height: 1.3333333333,
                              color: Color(0xff240f51),
                            ),
                          ),
                          TextSpan(
                            text: 'Welcome to ',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              height: 1.3333333333,
                              color: Color(0xff240f51),
                            ),
                          ),
                          TextSpan(
                            text: 'App',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 37),
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xff2c14dd),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Center(
                    child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransaksiApp()));
                  },
                  child: Text(
                    'Let’s Get Started',
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
            ),
          ],
        ),
      ),
    );
  }
}
