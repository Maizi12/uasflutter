// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/services.dart';
// import 'package:uas_flutter/regis.dart';
import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:uas_flutter/security/constant.dart';
import 'package:uas_flutter/security/jwt.dart';
// import 'package:uas_flutter/splash-2.dart';
// import 'firebase_options.dart';

void main() async {
  Encrypted enkrip = EncryptionData().encryptData(
      "muhammadazzamshidqi935@gmail.com", "mVOKdzoLzP1I8FONbsUitA==");
  print(enkrip.base64);
  // String email = EncryptionData().encryptData(
  //     "muhammadazzamshidqi935@gmail.com", "mVOKdzoLzP1I8FONbsUitA==");
  // print("email " + email);
  // String jwt = BuatJwt().Create(
  //     EncryptionData().encryptData(
  //         "muhammadazzamshidqi935@gmail.com", "mVOKdzoLzP1I8FONbsUitA=="),
  //     EncryptionData().encryptData("Testing123", "mVOKdzoLzP1I8FONbsUitA=="),
  //     "mVOKdzoLzP1I8FONbsUitA==");

  // print(jwt.toString());
  // CaLlo4iw1pYWELzxh7KoGg==iZiecbDb
  // String dekrip = EncryptionData().decryptData(
  //     "mVOKdzoLzP1I8FONbsUitA==", "3ocIlKlZigQMDRbA3ab6S7OhiZiecbDb");
  // print(dekrip);
  // print(jwt);
  print(EncryptionData.encryptionKeyGo + "mVOKdzoLzP1I8FONbsUitA==");
  Map<String, dynamic> decodedToken = JwtDecoder.decode(
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IjIzNGYzYTJlZTM0NDkyMjlkNDY4MDliMjlkNmUwNDRhIiwicGFzc3dvcmQiOiJhYzFjOGQ2NGZkMjNhZTVhN2VhYzViN2Y3ZmZlZTFmYSIsImlhdCI6MTcxNDcxMTYxNH0.jOXJGTletQaqb2BfDtQaNPs8nY91ixbUsE_TSfzikSE9Q4DEaxN2o0QHeor+g72Iw==");
  print(decodedToken["email"]);
  // print(EncryptionData().decryptData(decodedToken["email"],
  // EncryptionData.encryptionKeyGo + "mVOKdzoLzP1I8FONbsUitA=="));
  // Ngestuck karena ukuran jwt nya, mungkin pindah jadi enkrip dulu baru disusun jwt?
  // String enkrip = EncryptionData()
  //     .encryptData(splitted[1], "Q2FMbG80aXcxcFlXRUx6eGg3S29HZz09aVppZWNiRGI=");
  // print(enkrip);

  // WidgetsFlutterBinding.ensureInitialized();
  // try {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // } on FirebaseException catch (e) {
  //   print(e.message.toString());
  // }
  // runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: RegisApp(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//           centerTitle: true,
//         ),
//         // 425x868
//         body: Container(
//             color: Colors.cyan,
//             child: Column(children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     child: ElevatedButton(
//                         onPressed: () {
//                           SystemNavigator.pop();
//                         },
//                         child: const Text("<<< Exit")),
//                   )
//                 ],
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(
//                       width: 500,
//                       height: 100,
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text(
//                               'Institut Teknologi Tangerang Selatan',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Color(0xFF005A92),
//                                 fontSize: 20,
//                                 fontFamily: 'SF Pro Rounded',
//                                 fontWeight: FontWeight.w600,
//                                 height: 0,
//                               ),
//                             )
//                           ])),
//                   const SizedBox(
//                       width: 500,
//                       height: 300,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Image(image: AssetImage('assets/splash1.png'))
//                         ],
//                       )),
//                   const SizedBox(
//                     width: 343,
//                     height: 200,
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   SizedBox(
//                     width: 100,
//                   ),
//                   Container(
//                     child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Splash()));
//                         },
//                         child: const Text("Next >>>")),
//                   )
//                 ],
//               )
//             ])));
//   }
// }
