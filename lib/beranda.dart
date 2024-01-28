// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Beranda extends StatelessWidget {
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
                alignment: Alignment.center,
                child: Row(children: [
                  SizedBox(
                      width: 190,
                      height: 100,
                      child: Image.network(
                          "http://itts.ac.id/files/assets/img/profil/hGOk4410z0437sYst6203Q3J9.jpg",
                          fit: BoxFit.fitWidth)),
                  SizedBox(
                    width: 190,
                    height: 100,
                    child: Image.network(
                        "http://itts.ac.id/files/assets/img/fasilitas/6A39578116S05Bh1Z5cuy238T.png",
                        fit: BoxFit.fitWidth),
                  ),
                ])),
            Container(
                width: 600,
                height: 200,
                alignment: Alignment.center,
                child: Row(children: [
                  SizedBox(
                    width: 190,
                    height: 100,
                    child: Image.network(
                        "http://itts.ac.id/files/assets/img/fasilitas/2t81w2MXV06707Jvb61369n1.png",
                        fit: BoxFit.fitWidth),
                  ),
                  SizedBox(
                    width: 190,
                    height: 100,
                    child: Image.network(
                        "http://itts.ac.id/files/assets/img/fasilitas/4714jXs7V76q38f284C64j301.png",
                        fit: BoxFit.fitWidth),
                  ),
                ]))
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
                      'Home',
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
                      'Jadwal Kuliah',
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
                      'Profil',
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
